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
    @State private var isTodayMeal = false
    @State private var isCameraViewPresented = false
    @State private var isShowingMealDeleteAlert = false
    @State private var isShowingPlateDeleteAlert = false
    @State private var isReportPresented = false
    @State private var isBlockingAlertPresented = false
    
    var meal: Meal
    var user: User
    var commentList: [String: [Comment]]
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    MealDetailTopView(commentBar: commentBar, isMyMeal: $isMyMeal, isTodayMeal: $isTodayMeal, meal: meal)
                        .padding(.horizontal, .paddingHorizontal)
                    
                    TabView {
                        ForEach(meal.plates, id: \.id) { plate in
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
                    
                    if isMyMeal && isTodayMeal {
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
                        ForEach(commentList[meal.id!] ?? [], id:\.self) { comment in
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
                        }
                        Rectangle()
                            .fill(Color.white.opacity(0))
                            .frame(height: 80)
                    }
                    .padding([.top], 24)
                    .padding(.horizontal, .paddingHorizontal)

                }
            }
            .onTapGesture {
                self.hideKeyboard()
            }
            if isTodayMeal {
                ZStack {
                    VStack {
                        Spacer()
                        Rectangle()
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0)]),
                                               startPoint: UnitPoint(x: 0.5, y: 1-100/200),
                                               endPoint: .top)
                            )
                            .ignoresSafeArea()
                            .frame(height: 115)
                    }
                }
                AddCommentBarView(feedMeals: feedMeals, commentBar: commentBar, meal: meal)
                    .padding([.bottom], 10)
                    .padding(.horizontal, .paddingHorizontal)
            }
        }
        .navigationTitle(navTitleText)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete this meal", isPresented: $isShowingMealDeleteAlert, actions: {
            Button("Delete", role: .destructive, action: {
                feedMeals.deleteMeal(meal: meal)
            })
            Button("Cancel", role: .cancel, action: {})
        }, message: {
            Text("This action is irreversible.")
        })
        .alert("Blocking this user", isPresented: $isBlockingAlertPresented, actions: {
            Button("Block", role: .destructive, action: {
                if let blocker = loginState.user {
                    FirebaseConnector().setBlock(Blocker_id: blocker.id, Blocked_id: meal.userId)
                    Task{
                        try await FirebaseConnector().addBlockedId(user: blocker, BlockedId: meal.userId)
                    }
                }
            })
            Button("Cancel", role: .cancel, action: {})
        }, message: {
            Text("Blocked users won't be able to see your posts, and their posts won't appear on your feed..")
        })
        .sheet(isPresented: $isReportPresented) {
            ReportView(meal: meal, user: user, isReportPresented: $isReportPresented)
                    .environmentObject(loginState)
                }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                    Menu(content: {
                        if isMyMeal {
                            Button(role: .destructive, action: {
                                isShowingMealDeleteAlert = true
                            }, label: {
                                Label("Delete this meal", systemImage: "trash")
                            })
                        } else {
                                Button(role: .destructive, action: {
                                    isReportPresented = true
                                }, label: {
                                    Label("Report this meal", systemImage: "exclamationmark.triangle")
                                })
                                Button(role: .destructive, action: {
                                    isBlockingAlertPresented = true
                                }, label: {
                                    Label("Block this user", systemImage: "nosign")
                                })
                        }
                    }, label: {
                        Image(systemName: "ellipsis")
                    })
            }
        }
        .onAppear {
            configMyMealUI()
            configTodayMealUI()
        }
    }
}

extension MealDetailView {
    func configMyMealUI() {
        navTitleText = loginState.user?.id == user.id ? "I ate it." : "\(user.nickname) ate it."
        isMyMeal = loginState.user?.id == user.id ? true : false
    }
    
    func configTodayMealUI() {
        let timeDiff = Int(Date().timeIntervalSince(meal.uploadDate))
        isTodayMeal = timeDiff < 86400 ? true : false
    }
}


struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(commentBar: CommentBar(), meal: Meal.meals[2], user: User.users[0], commentList: [:])
    }
}
