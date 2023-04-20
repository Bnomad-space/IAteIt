//
//  FirebaseConnector.swift
//  IAteIt
//
//  Created by 박성수 on 2023/03/10.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage
import SwiftUI

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
    
    // user profile 이미지 업로드
    func uploadProfileImage(userId: String, image: UIImage, completion: @escaping(String) -> Void) {
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("profileImage/\(userId)")
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            print("DEBUG - fail compression")
            return
        }
        imageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("DEBUG \(error.localizedDescription)")
                return
            }
            imageRef.downloadURL { (url, error) in
                if let error = error {
                    print("DEBUG \(error.localizedDescription)")
                    return
                }
                guard let imageUrl = url else { return }
                
                completion(imageUrl.absoluteString)
            }
        }
    }
    
    // MARK: - meals
    
    // 새로운 meal 생성 (첫번째 plate 생성 포함, 캡션, 장소 없는 상태)
    func setNewMeal(meal: Meal) {
        let plate = meal.plates[0]
        let plates = FirebaseConnector.meals.document(meal.id).collection("plates")
        FirebaseConnector.meals.document(meal.id).setData([
            "id": meal.id,
            "userId": meal.userId,
            "uploadDate": meal.uploadDate
        ])
        plates.document(plate.id).setData([
            "id": plate.id,
            "mealId": meal.id,
            "imageUrl": plate.imageUrl,
            "uploadDate": plate.uploadDate
        ])
    }
    
    // 특정 meal에 새로운 plate 추가
    func setMealAddPlate(mealId: String, plate: Plate) {
        let plates = FirebaseConnector.meals.document(mealId).collection("plates")
        plates.document(plate.id).setData([
            "id": plate.id,
            "mealId": mealId,
            "imageUrl": plate.imageUrl,
            "uploadDate": plate.uploadDate
        ])
    }
    
    // plate 이미지 업로드
    func uploadPlateImage(mealId: String, plateId: String, image: UIImage, completion: @escaping(String) -> Void) {
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("plateImage/\(plateId)")
        let plates = FirebaseConnector.meals.document(mealId).collection("plates")
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            print("DEBUG - fail compression")
            return
        }
        imageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("DEBUG \(error.localizedDescription)")
                return
            }
            imageRef.downloadURL { (url, error) in
                if let error = error {
                    print("DEBUG \(error.localizedDescription)")
                    return
                }
                guard let imageUrl = url else { return }
                
                completion(imageUrl.absoluteString)
            }
        }
    }
    
    // 특정 meal에 caption 업데이트
    func setMealCaption(mealId: String, caption: String) {
        FirebaseConnector.meals.document(mealId).updateData([
            "caption": caption as Any
        ])
    }
    
    // 특정 meal에 location 업데이트
    func setMealLocation(mealId: String, location: String) {
        FirebaseConnector.meals.document(mealId).updateData([
            "location": location as Any
        ])
    }
    
    // 특정 meal의 모든 plate 데이터 가져오기
    func fetchMealPlates(mealId: String, completion: @escaping([Plate]) -> Void) {
        var plateHistory: [Plate] = []
        
        FirebaseConnector.meals.document(mealId).collection("plates").getDocuments() { (plateSnapshot, plateErr) in
            if let plateErr = plateErr {
                print("Error getting plates: \(plateErr.localizedDescription)")
            } else {
                for plateDocument in plateSnapshot!.documents {
                    print("\(plateDocument.documentID) => \(plateDocument.data())")

                    let plateDictionary = plateDocument.data()
                    guard let plateId = plateDictionary["id"] as? String,
                          let imageUrl = plateDictionary["imageUrl"] as? String,
                          let plateUploadTimestamp = plateDictionary["uploadDate"] as? Timestamp
                    else {
                        print("failed converting plates data")
                        return
                    }
                    let plateUploadDate = plateUploadTimestamp.dateValue()
                    let plate = Plate(id: plateId, mealId: mealId, imageUrl: imageUrl, uploadDate: plateUploadDate)
                    plateHistory.append(plate)
                }
                completion(plateHistory)
            }
        }
    }
    
    
    // 특정 user의 모든 meal 데이터 가져오기 (plate는 따로 fetchMealPlates로 가져와야함..)
    func fetchUserMealHistory(userId: String, completion: @escaping([Meal]) -> Void) {
        var mealHistory: [Meal] = []
        
        FirebaseConnector.meals.whereField("userId", isEqualTo: userId).getDocuments() { (mealSnapshot, mealErr) in
            if let mealErr = mealErr {
                print("Error getting documents: \(mealErr.localizedDescription)")
            } else {
                for mealDocument in mealSnapshot!.documents {
                    print("\(mealDocument.documentID) => \(mealDocument.data())")
                    
                    let mealDictionary = mealDocument.data()
                    guard let mealId = mealDictionary["id"] as? String,
                          let mealUploadTimestamp = mealDictionary["uploadDate"] as? Timestamp
                    else { return }
                    let mealUploadDate = mealUploadTimestamp.dateValue()
                    let caption = mealDictionary["caption"] as? String
                    let location = mealDictionary["location"] as? String

                    var plateHistory: [Plate] = []
                    
                    // 여기선 plates 안가져와짐 ㅜㅜ
//                    self.fetchMealPlates(mealId: mealId) { plates in
//                        plateHistory = plates
//                    }
                    let meal = Meal(id: mealId, userId: userId, location: location, caption: caption, uploadDate: mealUploadDate, plates: plateHistory)
                    mealHistory.append(meal)
                }
                completion(mealHistory)
            }
        }
    }
}
