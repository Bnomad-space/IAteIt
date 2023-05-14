//
//  MealDetailView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI

struct MealDetailView: View {
    @StateObject var commentBar: CommentBar
    @StateObject var cameraViewModel: CameraViewModel
    @ObservedObject var loginState: LoginStateModel
    @ObservedObject var feedMeals: FeedMealModel
    @State private var navTitleText = ""
    @State private var isMyMeal = false
    @State private var isCameraViewPresented = false
    
    var meal: Meal
    var user: User
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    MealDetailTopView(commentBar: commentBar, isMyMeal: $isMyMeal, meal: meal)
                        .padding(.horizontal, .paddingHorizontal)
                    
                    TabView {
                        ForEach(meal.plates, id: \.self) { plate in
                            PhotoCardView(plate: plate)
                                .padding(.horizontal, .paddingHorizontal)
                        }
                    }
                    .frame(minHeight: 358)
                    .tabViewStyle(.page)
                    
                    if isMyMeal {
                        HStack {
                            Spacer()
                            Button(action: {
                                cameraViewModel.type = .addPlate
                                isCameraViewPresented.toggle()
                            }, label: {
                                AddPlateButtonView()
                            })
                        }
                        .padding(.horizontal, .paddingHorizontal)
                        .fullScreenCover(isPresented: $isCameraViewPresented, content: {
                            CameraView(loginState: loginState, feedMeals: feedMeals, viewModel: cameraViewModel, mealAddPlateTo: meal)
                        })
                    }
                    
                    if let targetMeal = feedMeals.mealList.first { $0.id == meal.id }  {
                        if let comments = targetMeal.comments {
                            VStack(alignment: .leading, spacing: 12) {
                                ForEach(comments, id: \.self) { comment in
                                    if let user = feedMeals.allUsers.first { $0.id == comment.userId } {
                                        CommentView(user: user, comment: comment)
                                    } else {
                                        Text("Comment Error")
                                    }
                                }
                            }
                            .padding([.top], 24)
                            .padding(.horizontal, .paddingHorizontal)
                        }
                    }
                }
            }
            AddCommentBarView(feedMeals: feedMeals, commentBar: commentBar, meal: meal)
                .padding([.bottom], 10)
                .padding(.horizontal, .paddingHorizontal)
        }
        .navigationTitle(navTitleText)
        .onTapGesture {
            self.hideKeyboard()
        }
        .onAppear {
            configMyMealUI()
        }
    }
}

extension MealDetailView {
    func configMyMealUI() {
        if loginState.user?.id == user.id {
            isMyMeal = true
            navTitleText = "I ate it."
        } else {
            isMyMeal = false
            navTitleText = "\(user.nickname) ate it."
        }
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(commentBar: CommentBar(), cameraViewModel: CameraViewModel(), loginState: LoginStateModel(), feedMeals: FeedMealModel(), meal: Meal.meals[2], user: User.users[0])
    }
}
