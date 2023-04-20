//
//  FirebaseTestView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/04/18.
//

import SwiftUI

struct FirebaseTestView: View {
    
    var body: some View {
        VStack {
            
            // 프로필이미지 업로드, 회원가입
            Button(action: {
                var user = User(id: "testUser1Id", nickname: "testUser1Nickname")
                let image = UIImage(named: "Sample_Profile1")
                if let image = image {
                    FirebaseConnector().uploadProfileImage(userId: user.id, image: image) { url in
                        user.profileImageUrl = url
                        FirebaseConnector().setNewUser(user: user)
                    }
                }
            }, label: {
                Text("Sign up")
            })
            
            // 프로필 정보 수정
            Button(action: {
                let user = User(id: "testUser1Id", nickname: "testUser1NicknameEdited", profileImageUrl: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80")
                FirebaseConnector().updateUser(user: user)
            }, label: {
                Text("Edit User")
            })
            
            // 특정 user 정보 가져오기
            Button(action: {
                FirebaseConnector().fetchUser(id: "testUser1Id") { user in
                    print(user.id)
                    print(user.nickname)
                    if let profileImage = user.profileImageUrl {
                        print(profileImage)
                    }
                }
            }, label: {
                Text("Fetch user")
            })
            
            // 새로운 meal 생성 & plate 이미지 업로드
            Button(action: {
                let image = UIImage(named: "Sample_McMorning")
                var meal = Meal(id: "testMealId1", userId: "testUser1Id", uploadDate: Date(), plates: [])
                var plate = Plate(id: "testPlateId1", mealId: meal.id, imageUrl: "", uploadDate: Date())
                if let image = image {
                    FirebaseConnector().uploadPlateImage(mealId: meal.id, plateId: plate.id, image: image) { url in
                        plate.imageUrl = url
                        meal.plates.append(plate)
                        FirebaseConnector().setNewMeal(meal: meal)
                    }
                }
            }, label: {
                Text("Create a meal")
            })
            
            // meal에 plate 추가
            Button(action: {
                let image = UIImage(named: "Sample_McMorning")
                var plate2 = Plate(id: "testPlateId2", mealId: "testMealId1", imageUrl: "", uploadDate: Date())
                if let image = image {
                    FirebaseConnector().uploadPlateImage(mealId: plate2.mealId, plateId: plate2.id, image: image) { url in
                        plate2.imageUrl = url
                        FirebaseConnector().setMealAddPlate(mealId: plate2.mealId, plate: plate2)
                    }
                }
            }, label: {
                Text("Add a plate to a meal")
            })
            
            
        }
    }
}