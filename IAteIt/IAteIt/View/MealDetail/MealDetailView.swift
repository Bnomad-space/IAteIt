//
//  MealDetailView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI
import MessageUI

struct MealDetailView: View {
    @StateObject var commentBar = CommentBar()
    @EnvironmentObject var cameraViewModel: CameraViewModel
    @EnvironmentObject var loginState: LoginStateModel
    @EnvironmentObject var feedMeals: FeedMealModel
    @State private var navTitleText = ""
    @State private var isMyMeal = false
    @State private var isCameraViewPresented = false
    @State private var isShowingMealDeleteAlert = false
    @State private var isShowingPlateDeleteAlert = false
    @State private var isReportPresented = false
    
    
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
                                .contextMenu {
                                    if isMyMeal && (meal.plates.count > 1) {
                                        Button(role: .destructive, action: {
                                            isShowingPlateDeleteAlert = true
                                            print(plate)
                                        }, label: {
                                            Label("Delete this plate", systemImage: "trash")
                                        })
                                    }
                                }
                                .alert("Delete this plate", isPresented: $isShowingPlateDeleteAlert, actions: {
                                    Button("Delete", role: .destructive, action: {
                                        feedMeals.deletePlate(meal: meal, plate: plate)
                                    })
                                    Button("Cancel", role: .cancel, action: {})
                                }, message: {
                                    Text("This action is irreversible.")
                                })
                        }
                    }
                    .frame(minHeight: 358)
                    .tabViewStyle(.page)
                    
                    if isMyMeal {
                        HStack {
                            Spacer()
                            Button(action: {
                                cameraViewModel.reset()
                                cameraViewModel.type = .addPlate
                                isCameraViewPresented.toggle()
                            }, label: {
                                AddPlateButtonView()
                            })
                        }
                        .padding(.horizontal, .paddingHorizontal)
                        .fullScreenCover(isPresented: $isCameraViewPresented, content: {
                            CameraView(viewModel: cameraViewModel, mealAddPlateTo: meal)
                                .environmentObject(loginState)
                                .environmentObject(feedMeals)
                        })
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(feedMeals.commentList[meal.id!] ?? [], id:\.self) { comment in
                            if let user = feedMeals.allUsers.first(where: { $0.id == comment.userId }) {
                                let isMyComment = loginState.user?.id == comment.userId
                                ZStack {
                                    CommentView(user: user, comment: comment)
                                    HStack {
                                        Spacer()
                                        if isMyComment {
                                            Menu(content: {
                                                Button(role: .destructive, action: {
                                                    feedMeals.deleteComment(meal: meal, comment: comment)
                                                }, label: {
                                                    Label("Delete this comment", systemImage: "trash")
                                                })
                                            }, label: {
                                                Image(systemName: "ellipsis")
                                            })
                                        }
                                    }
                                }
                            } else {
                                Text("Comment Error")
                            }
                        }                    }
                    .padding([.top], 24)
                    .padding(.horizontal, .paddingHorizontal)
                }
            }
            AddCommentBarView(feedMeals: feedMeals, commentBar: commentBar, meal: meal)
                .padding([.bottom], 10)
                .padding(.horizontal, .paddingHorizontal)
        }
        .navigationTitle(navTitleText)
        .alert("Delete this meal", isPresented: $isShowingMealDeleteAlert, actions: {
            Button("Delete", role: .destructive, action: {
                feedMeals.deleteMeal(meal: meal)
            })
            Button("Cancel", role: .cancel, action: {})
        }, message: {
            Text("This action is irreversible.")
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isMyMeal {
                    Menu(content: {
                        Button(role: .destructive, action: {
                            isShowingMealDeleteAlert = true
                        }, label: {
                            Label("Delete this meal", systemImage: "trash")
                        })
                    }, label: {
                        Image(systemName: "ellipsis")
                    })
                } else {
                    Button(action: {
                        isReportPresented = true
                    }, label: {
                        Image(systemName: "exclamationmark.triangle.fill")
                    })
                    .sheet(isPresented: $isReportPresented) {
                        ReportView(meal: meal, isReportPresented: $isReportPresented)
                            .environmentObject(loginState)
                            }
                }
            }
        }
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
        MealDetailView(commentBar: CommentBar(), meal: Meal.meals[2], user: User.users[0])
    }
}
