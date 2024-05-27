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
    @EnvironmentObject var cameraStore: CameraStore
    @EnvironmentObject var loginState: LoginStateStore
    @EnvironmentObject var feedMeals: FeedMealStore
    @State private var isCameraViewPresented = false
    @Binding var isActive: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Button(action: {
                    cameraStore.getReadyForCameraView(.newMeal)
                    isCameraViewPresented.toggle()
                }, label: {
                    AddMealView()
                        .padding([.top, .bottom], 24)
                        .padding(.horizontal, .paddingHorizontal)
                })
                .tint(.black)
                .fullScreenCover(
                    isPresented: $isCameraViewPresented,
                    content: { CameraView() }
                )
                
                switch !feedMeals.isFeedEmpty {
                case true:
                    ForEach(feedMeals.mealList) { eachMeal in
                        if let mealOwner = feedMeals.allUsers.first(where: { $0.id == eachMeal.userId }) {
                            VStack(spacing: 8) {
                                FeedHeaderView(feedMeals: feedMeals, meal: eachMeal, user: mealOwner)
                                    .padding(.horizontal, .paddingHorizontal)
                                
                                NavigationLink(destination: MealDetailView(meal: eachMeal, user: mealOwner, commentList: feedMeals.commentList)
                                ) {
                                    TabView {
                                        ForEach(eachMeal.plates, id: \.id) { plate in
                                            PhotoCardView(plate: plate)
                                                .padding(.horizontal, .paddingHorizontal)
                                        }
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                .frame(minHeight: 358)
                                .tabViewStyle(.page)
                                
                                NavigationLink(destination: MealDetailView(meal: eachMeal, user: mealOwner, commentList: feedMeals.commentList)
                                ) {
                                    FeedFooterView(meal: eachMeal)
                                        .padding(.horizontal, .paddingHorizontal)
                                        .padding(.bottom, 24)
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
        .refreshable {
            do {
                try await Task.sleep(nanoseconds: 1_000_000_000)
                feedMeals.refreshMealsAndUsers()
            } catch {
                print("Error refreshing data: \(error)")
            }
        }
        .navigationBarItems(leading:
                                FeedTitleView()
            .padding([.leading], UIScreen.main.bounds.size.width/2-65) //TODO: 정렬다시
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(
                    destination: MyProfileView(),
                    isActive: $isActive,
                    label: { ProfilePhotoButtonView(loginState: loginState) }
                )
                .isDetailLink(false)
                .simultaneousGesture(TapGesture().onEnded {
                    if let user = loginState.user {
                        feedMeals.getUserMealHistory(user: user)
                    }
                })
            }
        }
        .navigationTitle("")
        .fullScreenCover(
            isPresented: $loginState.isAppleLoginRequired,
            content: { LoginView(loginState: loginState) }
        )
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(isActive: .constant(false))
            .environmentObject(CameraStore())
            .environmentObject(LoginStateStore())
            .environmentObject(FeedMealStore())
    }
}
