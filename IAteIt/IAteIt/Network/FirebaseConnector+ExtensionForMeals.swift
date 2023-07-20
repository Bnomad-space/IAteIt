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
    static let meals2 = Firestore.firestore().collection("meals2")
    
    // 새로운 meal 생성 (첫번째 plate 생성 포함, 캡션, 장소 없는 상태)
    func setNewMeal(meal: Meal) async throws -> String {
        let date = Date().toDateString2()
        let mealRef = FirebaseConnector.meals2.document(date).collection("mealsByDay")
        let document = mealRef.document()
        let documentId = document.documentID
        var plate = meal.plates[0]
        plate.mealId = documentId
        try await document.setData([
            "id": documentId,
            "userId": meal.userId,
            "uploadDate": meal.uploadDate
        ])
        try await document.updateData([
            "plates": FieldValue.arrayUnion([plate.firebaseData])
        ])
        return documentId
    }
    
    // 특정 meal에 새로운 plate 추가
    func addPlateToMeal(meal: Meal, plate: Plate) async throws {
        guard let mealId = meal.id else { return }
        let dateString = meal.uploadDate.toDateString2()
        let mealRef = FirebaseConnector.meals2.document(dateString).collection("mealsByDay")
        
        try await mealRef.document(mealId).updateData([
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
    func setMealCaption(meal: Meal, caption: String) async {
        guard let mealId = meal.id else { return }
        let date = meal.uploadDate.toDateString2()
        let mealRef = FirebaseConnector.meals2.document(date).collection("mealsByDay")
        
        try? await mealRef.document(mealId).updateData([
            "caption": caption as Any
        ])
    }
    
    // 특정 meal에 location 업데이트
    func setMealLocation(meal: Meal, location: String) async {
        guard let mealId = meal.id else { return }
        let date = meal.uploadDate.toDateString2()
        let mealRef = FirebaseConnector.meals2.document(date).collection("mealsByDay")
        
        try? await mealRef.document(mealId).updateData([
            "location": location as Any
        ])
    }
    
    // 특정 user의 모든 meal 데이터 가져오기
    func fetchUserMealHistory(userId: String) async throws -> [Meal] {
        var mealHistory: [Meal] = []
        
        let snapshots = try await Firestore.firestore().collectionGroup("mealsByDay")
            .whereField("userId", isEqualTo: userId)
            .order(by: "uploadDate", descending: true)
            .getDocuments()
        
        let oldsnapshots = try await FirebaseConnector.meals
            .whereField("userId", isEqualTo: userId)
            .getDocuments()
                
        for document in snapshots.documents {
            let meal = try document.data(as: Meal.self)
            mealHistory.append(meal)
        }
        
        for document in oldsnapshots.documents {
            let meal = try document.data(as: Meal.self)
            mealHistory.append(meal)
        }
        
        return mealHistory
    }
    
    // 24시간 이내 업로드된 모든 meal 데이터 가져오기
    func fetchMealIn24Hours(date: Date) async throws -> [Meal] {
        var meals: [Meal] = []

        let toTime = date
        let toTimestamp = Timestamp(date: toTime)
        let fromTime = date-3600*24
        let fromTimestamp = Timestamp(date: fromTime)

        let snapshotsToday = try await FirebaseConnector.meals2.document(date.toDateString2()).collection("mealsByDay")
            .order(by: "uploadDate", descending: true)
            .getDocuments()
        
        let snapshotsYesterday = try await FirebaseConnector.meals2.document(fromTime.toDateString2()).collection("mealsByDay")
            .order(by: "uploadDate", descending: true)
            .whereField("uploadDate", isGreaterThan: fromTimestamp)
            .whereField("uploadDate", isLessThanOrEqualTo: toTimestamp)
            .getDocuments()
        
        for document in snapshotsToday.documents {
            let meal = try document.data(as: Meal.self)
            meals.append(meal)
        }
        
        for document in snapshotsYesterday.documents {
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
    func deleteMeal(meal: Meal) async throws {
        guard let mealId = meal.id else { return }
        let date = meal.uploadDate.toDateString2()
        let mealRef = FirebaseConnector.meals2.document(date).collection("mealsByDay")
        
        try await mealRef.document(mealId).delete()
    }
    
    // 특정 plate 삭제
    func deletePlate(meal: Meal, plate: Plate) async throws {
        guard let mealId = meal.id else { return }
        let date = meal.uploadDate.toDateString2()
        let mealRef = FirebaseConnector.meals2.document(date).collection("mealsByDay")
        
        try await mealRef.document(mealId).updateData([
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
