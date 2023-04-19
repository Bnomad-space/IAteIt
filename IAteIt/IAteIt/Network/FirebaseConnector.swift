//
//  FirebaseConnector.swift
//  IAteIt
//
//  Created by 박성수 on 2023/03/10.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirebaseConnector {
    
    /*
     TODO: - 논의된 모델로 Firebase에는 어떻게 저장할 건지 다시 바꿔주어야 함
     
     사용 방법:
     FirebaseConnector.users.document("testDocument").setData(["id":"randomId", "nickname":"jake", "profileImageUrl":"blah"])
     
     */
    
    static let users = Firestore.firestore().collection("users")
    static let meals = Firestore.firestore().collection("meals")
    static let comments = Firestore.firestore().collection("comments")
    
    // MARK: - users
    
    // 새로운 user 생성(회원가입)
    func setNewUser(user: User) {
        FirebaseConnector.users.document(user.id).setData([
            "id": user.id,
            "nickname": user.nickname,
            "profileImageUrl": user.profileImageUrl as Any
        ])
    }
    
    // user 정보 업데이트(프로필 수정)
    func updateUser(user: User) {
        FirebaseConnector.users.document(user.id)
            .updateData([
            "id": user.id,
            "nickname": user.nickname,
            "profileImageUrl": user.profileImageUrl as Any
        ])
    }
    
    // user 데이터 가져오기
    func fetchUser(id: String, completion: @escaping(User) -> Void) {
        FirebaseConnector.users.document(id).getDocument { (document, error) in
            guard
                let document = document, document.exists,
                let dictionary = document.data(),
                let nickname = dictionary["nickname"] as? String
            else {
                print("Document does not exist")
                return
            }
            let profileImageUrl = dictionary["profileImageUrl"] as? String
            let user = User(id: id, nickname: nickname, profileImageUrl: profileImageUrl)
            
            completion(user)
        }
    }
}
