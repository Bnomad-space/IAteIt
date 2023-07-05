//
//  FirebaseConnector+ExtensionForMeals.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/04/23.
//

import Firebase
import FirebaseFirestore
import FirebaseStorage
import SwiftUI

extension FirebaseConnector {
    static let meals = Firestore.firestore().collection("meals")
    
    // 새로운 meal 생성 (첫번째 plate 생성 포함, 캡션, 장소 없는 상태)
    func setNewMeal(meal: Meal) async throws -> String {
        let document = FirebaseConnector.meals.document()
        let documentId = document.documentID
        var plate = meal.plates[0]
        plate.mealId = documentId
        try await document.setData([
            "id": documentId,
            "userId": meal.userId,
            "uploadDate": meal.uploadDate
        ])
        try await FirebaseConnector.meals.document(documentId).updateData([
            "plates": FieldValue.arrayUnion([plate.firebaseData])
        ])
        return documentId
    }
    
    // 특정 meal에 새로운 plate 추가
    func addPlateToMeal(mealId: String, plate: Plate) async throws {
        try await FirebaseConnector.meals.document(mealId).updateData([
            "plates": FieldValue.arrayUnion([plate.firebaseData])
        ])
    }
    
    // plate 이미지 업로드
    func uploadPlateImage(plateId: String, image: UIImage) async throws -> String {
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("plateImage/\(plateId)")
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            throw URLError(.badServerResponse)
        }
        let returnedMetaData = try await imageRef.putDataAsync(imageData, metadata: nil)
        let imageUrl: URL = try await imageRef.downloadURL()
        
        return imageUrl.absoluteString
    }
    
    // 특정 meal에 caption 업데이트
    func setMealCaption(mealId: String, caption: String) async {
        try? await FirebaseConnector.meals.document(mealId).updateData([
            "caption": caption as Any
        ])
    }
    
    // 특정 meal에 location 업데이트
    func setMealLocation(mealId: String, location: String) async {
        try? await FirebaseConnector.meals.document(mealId).updateData([
            "location": location as Any
        ])
    }
    
    // 특정 user의 모든 meal 데이터 가져오기
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

                    let meal = Meal(id: mealId, userId: userId, location: location, caption: caption, uploadDate: mealUploadDate, plates: [])
                    mealHistory.append(meal)
                }
                completion(mealHistory)
            }
        }
    }
    
    // 24시간 이내 업로드된 모든 meal 데이터 가져오기
    func fetchMealIn24Hours(date: Date) async throws -> [Meal] {
        var meals: [Meal] = []

        let toTime = date
        let toTimestamp = Timestamp(date: toTime)
        let fromTime = date-3600*24
        let fromTimestamp = Timestamp(date: fromTime)

        let snapshots = try await FirebaseConnector.meals.order(by: "uploadDate", descending: true)
            .whereField("uploadDate", isGreaterThan: fromTimestamp)
            .whereField("uploadDate", isLessThanOrEqualTo: toTimestamp)
            .getDocuments()
        
        for document in snapshots.documents {
            let meal = try document.data(as: Meal.self)
            meals.append(meal)
        }
        return meals
    }
    
    // plate 이미지 서버에서 삭제
    func deletePlateImage(plateId: String) async throws {
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("plateImage/\(plateId)")
        
        try await imageRef.delete()
    }
    
    // 특정 meal 삭제
    func deleteMeal(mealId: String) async throws {
        try await FirebaseConnector.meals.document(mealId).delete()
    }
    
    // 특정 plate 삭제
    func deletePlate(mealId: String, plate: Plate) async throws {
        try await FirebaseConnector.meals.document(mealId).updateData([
            "plates": FieldValue.arrayRemove([plate.firebaseData])
        ])
    }
    
    // 특정 user의 모든 meal 삭제(회원탈퇴)
    func deleteMealsByUser(userId: String) async throws {
        let snapshots = try await FirebaseConnector.meals.whereField("userId", isEqualTo: userId).getDocuments()
        
        for document in snapshots.documents {
            let meal = try document.data(as: Meal.self)
            
            for plate in meal.plates {
                try await deletePlateImage(plateId: plate.id)
            }
            try await FirebaseConnector.meals.document(document.documentID).delete()
        }
    }
}
