//
//  FirebaseConnector.swift
//  IAteIt
//
//  Created by 박성수 on 2023/03/10.
//

import Firebase
import FirebaseFirestore
import FirebaseStorage
import SwiftUI

final class FirebaseConnector {
    
    /*
     TODO: - 논의된 모델로 Firebase에는 어떻게 저장할 건지 다시 바꿔주어야 함
     
     사용 방법:
     FirebaseConnector.users.document("testDocument").setData(["id":"randomId", "nickname":"jake", "profileImageUrl":"blah"])
     
     */
    
    static let shared = FirebaseConnector()
    static let users = Firestore.firestore().collection("users")
    
    // 새로운 user 생성(회원가입)
    func setNewUser(user: User) async throws {
        try await FirebaseConnector.users.document(user.id).setData([
            "id": user.id,
            "nickname": user.nickname,
            "profileImageUrl": user.profileImageUrl as Any
        ])
    }
    
    // username 중복 체크(회원가입 시)
    func checkExistingUsername(username: String, completion: @escaping(Bool) -> Void) {
        FirebaseConnector.users.whereField("nickname", isEqualTo: username)
            .getDocuments() { (snapshot, err) in
                if let snapshot = snapshot {
                    if snapshot.count > 0 {
                        print("same username exists: \(snapshot.count)")
                        completion(true)
                    } else {
                        print("unique username")
                        completion(false)
                    }
                } else {
                    if let err = err {
                        print(err.localizedDescription)
                    }
                }
            }
    }
    
    // 가입된 username 모두 가져오기
    func fetchAllUsernames(completion: @escaping([String]) -> Void) {
        var usernameList: [String] = []
        
        FirebaseConnector.users.getDocuments() { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    let dict = document.data()
                    guard let username = dict["nickname"] as? String else { return }
                    usernameList.append(username)
                }
                completion(usernameList)
            }
        }
    }
    
    // 모든 User 가져오기
    func fetchAllUsers() async throws -> [User] {
        var users: [User] = []

        let snapshots = try await FirebaseConnector.users.getDocuments()
        
        for document in snapshots.documents {
            let user = try document.data(as: User.self)
            users.append(user)
        }
        return users
    }
    
    // 이미 가입된 유저인지 체크
    func checkExistingUser(userUid: String) async throws -> Bool {
        let document = try await FirebaseConnector.users.document(userUid).getDocument()
        if document.exists {
            print("이미 가입된 유저 로그인.")
            return true
        } else {
            print("Document does not exist. 새로운 유저 로그인.")
            return false
        }
    }
    
    // user 정보 업데이트(프로필 수정)
    func updateUser(user: User) async throws {
        try await FirebaseConnector.users.document(user.id)
            .updateData([
            "id": user.id,
            "nickname": user.nickname,
            "profileImageUrl": user.profileImageUrl as Any
        ])
    }
    
    // user 데이터 가져오기
    func fetchUser(id: String) async throws -> User {
        let snapshot = try await FirebaseConnector.users.document(id).getDocument()
        guard let data = snapshot.data(),
              let nickname = data["nickname"] as? String
        else { throw URLError(.badServerResponse) }
        let profileImageUrl = data["profileImageUrl"] as? String
        let user = User(id: id, nickname: nickname, profileImageUrl: profileImageUrl)
            
        return user
    }
    
    // user profile 이미지 업로드
    func uploadProfileImage(userId: String, image: UIImage) async throws -> String {
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("profileImage/\(userId)/")
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            throw URLError(.badServerResponse)
        }
        let returnedMetaData = try await imageRef.putDataAsync(imageData, metadata: nil)
        let imageUrl: URL = try await imageRef.downloadURL()
        
        return imageUrl.absoluteString
    }
}
