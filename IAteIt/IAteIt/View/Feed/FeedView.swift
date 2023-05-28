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
    @StateObject var cameraViewModel = CameraViewModel()
    @EnvironmentObject var loginState: LoginStateModel
    @EnvironmentObject var feedMeals: FeedMealModel
    @State private var isCameraViewPresented = false
    @Binding var isActive: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 27) {
                Button(action: {
                    cameraViewModel.reset()
                    cameraViewModel.type = .newMeal
                    isCameraViewPresented.toggle()
                }, label: {
                    AddMealView()
                        .padding([.top], 24)
                        .padding(.horizontal, .paddingHorizontal)
                })
                .tint(.black)
                .fullScreenCover(isPresented: $isCameraViewPresented, content: {
                    CameraView(viewModel: cameraViewModel)
                })
                switch feedMeals.mealList.count != 0 {
                case true:
                    ForEach(feedMeals.mealList, id: \.self) { eachMeal in
                        if let user = feedMeals.allUsers.first(where: { $0.id == eachMeal.userId }) {
                            VStack(spacing: 8) {
                                FeedHeaderView(feedMeals: feedMeals, meal: eachMeal, user: user)
                                    .padding(.horizontal, .paddingHorizontal)
                                NavigationLink(destination: MealDetailView(meal: eachMeal, user: user)
                                    .environmentObject(cameraViewModel)
                                    .environmentObject(loginState)
                                    .environmentObject(feedMeals)
                                ) {
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
                                NavigationLink(destination: MealDetailView(meal: eachMeal, user: user)
                                    .environmentObject(cameraViewModel)
                                    .environmentObject(loginState)
                                    .environmentObject(feedMeals)
                                ) {
                                    //위 링크랑 다르게, 비리얼처럼 댓글창에 포커싱되어서 넘어가는 건 어떨지 해서 분리
                                    FeedFooterView(meal: eachMeal)
                                        .padding(.horizontal, .paddingHorizontal)
                                        .environmentObject(feedMeals)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                default:
                    Spacer()
                    EmptyMealView()
                    Spacer()
                }
            }
        }
        .navigationBarItems(leading:
                                FeedTitleView()
            .padding([.leading], UIScreen.main.bounds.size.width/2-50) //TODO: 정렬다시
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(
                    destination: MyProfileView().environmentObject(loginState),
                    isActive: $isActive,
                    label: { ProfilePhotoButtonView(loginState: loginState) }
                )
                .isDetailLink(false)
            }
        }
        .navigationTitle("")
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
        FeedView(cameraViewModel: CameraViewModel(), isActive: .constant(false))
    }
}
