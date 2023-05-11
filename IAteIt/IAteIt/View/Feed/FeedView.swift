//
//  FeedView.swift
//  IAteIt
//
//  Created by Beone on 2023/03/07.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct FeedView: View {
    @ObservedObject var loginState: LoginStateModel
    @ObservedObject var feedMeals: FeedMealModel
    @State private var isCameraViewPresented = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 27) {
                Button(action: {
                    isCameraViewPresented.toggle()
                }, label: {
                    AddMealView()
                        .padding([.top], 24)
                        .padding(.horizontal, .paddingHorizontal)
                })
                .tint(.black)
                .fullScreenCover(isPresented: $isCameraViewPresented, content: {
                    CameraView(loginState: loginState, feedMeals: feedMeals)
                })
                ForEach(feedMeals.mealList, id: \.self) { eachMeal in
                    if let indexOfUser = feedMeals.userList.firstIndex(where: { $0.id == eachMeal.userId }) {
                        VStack(spacing: 8) {
                            FeedHeaderView(feedMeals: feedMeals, meal: eachMeal, user: feedMeals.userList[indexOfUser])
                                .padding(.horizontal, .paddingHorizontal)
                            NavigationLink(destination: MealDetailView(commentBar: CommentBar(), loginState: loginState, meal: eachMeal, user: feedMeals.userList[indexOfUser])) {
                                TabView {
                                    ForEach(eachMeal.plates, id: \.self) { plate in
                                        PhotoCardView(plate: plate)
                                            .padding(.horizontal, .paddingHorizontal)
                                    }
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(minHeight: 358)
                            .tabViewStyle(.page)
                            NavigationLink(destination: MealDetailView(commentBar: CommentBar(), loginState: loginState, meal: eachMeal, user: feedMeals.userList[indexOfUser])) {
                                //위 링크랑 다르게, 비리얼처럼 댓글창에 포커싱되어서 넘어가는 건 어떨지 해서 분리
                                FeedFooterView(meal: eachMeal)
                                    .padding(.horizontal, .paddingHorizontal)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
        }
        .navigationBarItems(leading:
                                FeedTitleView()
            .padding([.leading], UIScreen.main.bounds.size.width/2-50) //TODO: 정렬다시
        )
        .navigationBarItems(trailing: NavigationLink(destination: MyProfileView()) {
            ProfilePhotoButtonView(loginState: loginState)
        })
        .onAppear {
            Task {
                feedMeals.getMealListIn24Hours()
            }
        }
        .fullScreenCover(isPresented: self.$loginState.isAppleLoginRequired, content: {
            LoginView(loginState: loginState)
        })
        .fullScreenCover(isPresented: self.$loginState.isSignUpViewPresent, content: {
            SignUpView(loginState: loginState)
        })
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(loginState: LoginStateModel(), feedMeals: FeedMealModel())
    }
}
