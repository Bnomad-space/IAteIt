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
            VStack {
                // 프로필이미지 업로드, 회원가입
//                Button(action: {
//                    var user = User(id: "testUser2Id", nickname: "testUser2Nickname")
//                    let image = UIImage(named: "Sample_Profile2")
//                    if let image = image {
//                        FirebaseConnector().uploadProfileImage(userId: user.id, image: image) { url in
//                            user.profileImageUrl = url
//                            FirebaseConnector().setNewUser(user: user)
//                        }
//                    }
//                }, label: {
//                    Text("Sign up")
//                })
                
                // 프로필 정보 수정
                Button(action: {
                    let user = User(id: "testUser1Id", nickname: "testUser1NicknameEdited", profileImageUrl: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80")
//                    FirebaseConnector().updateUser(user: user)
                }, label: {
                    Text("Edit User")
                })
                
                // 특정 user 정보 가져오기
//                Button(action: {
//                    FirebaseConnector().fetchUser(id: "testUser2Id") { user in
//                        print(user.id)
//                        print(user.nickname)
//                        if let profileImage = user.profileImageUrl {
//                            print(profileImage)
//                        }
//                    }
//                }, label: {
//                    Text("Fetch user")
//                })
            }
            
            VStack {
                // 새로운 meal 생성 & plate 이미지 업로드
//                Button(action: {
//                    let image = UIImage(named: "Sample_Hashbrown")
//                    var meal = Meal(id: "testMealId4", userId: "testUser2Id", uploadDate: Date(), plates: [])
//                    var plate = Plate(id: "testPlateId5", mealId: meal.id, imageUrl: "", uploadDate: Date())
//                    if let image = image {
//                        FirebaseConnector().uploadPlateImage(mealId: meal.id, plateId: plate.id, image: image) { url in
//                            plate.imageUrl = url
//                            meal.plates.append(plate)
//                            FirebaseConnector().setNewMeal(meal: meal)
//                        }
//                    }
//                }, label: {
//                    Text("Create a meal")
//                })
                
                // meal에 plate 추가
//                Button(action: {
//                    let image = UIImage(named: "Sample_McMorning")
//                    var plate2 = Plate(id: "testPlateId2", mealId: "testMealId1", imageUrl: "", uploadDate: Date())
//                    if let image = image {
//                        FirebaseConnector().uploadPlateImage(mealId: plate2.mealId, plateId: plate2.id, image: image) { url in
//                            plate2.imageUrl = url
//                            FirebaseConnector().setMealAddPlate(mealId: plate2.mealId, plate: plate2)
//                        }
//                    }
//                }, label: {
//                    Text("Add a plate to a meal")
//                })
                
                // meal에 caption 추가/수정
                Button(action: {
                    let caption = "맥모닝 맛있다"
//                    FirebaseConnector().setMealCaption(mealId: "testMealId1", caption: caption)
                }, label: {
                    Text("Caption")
                })
                
                // meal에 location 추가/수정
                Button(action: {
                    let location = "맥도날드"
//                    FirebaseConnector().setMealLocation(mealId: "testMealId1", location: location)
                }, label: {
                    Text("Location")
                })
                
                // 특정 user의 모든 meal 데이터 가져오기
//                Button(action: {
//                    FirebaseConnector().fetchUserMealHistory(userId: "testUser1Id") { meals in
//                        print("number of meals: \(meals.count)")
//                    }
//                }, label: {
//                    Text("Getting meal history of a user")
//                })
                
                // 24시간 이내 모든 meal 데이터 가져오기
//                Button(action: {
//                    FirebaseConnector().fetchMealIn24Hours(date: Date()) { meals in
//                        print("number of meals in 24 hours: \(meals.count)")
//                    }
//                }, label: {
//                    Text("get meals in 24 hours")
//                })
            }
            
            VStack {
                // 새로운 comment 생성
                Button(action: {
                    let comment = Comment(id: "testCommentId1", userId: "testUser1Id", mealId: "testMealId1", comment: "첫번째 코멘트", uploadDate: Date())
//                    FirebaseConnector().setNewComment(comment: comment)
                }, label: {
                    Text("new comment")
                })
                
                // 특정 meal의 모든 comment 데이터 가져오기
                Button(action: {
//                    FirebaseConnector().fetchMealComments(mealId: "testMealId1") { comments in
//                        print("number of comments: \(comments.count)")
//                        print(comments[0].comment)
//                    }
                }, label: {
                    Text("getting all comments for a meal")
                })
            }
        }
    }
}
