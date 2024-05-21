//
//  MealListView.swift
//  IAteIt
//
//  Created by Youngwoong Choi on 2023/03/12.
//

import SwiftUI

struct MealListView: View {
    @EnvironmentObject var loginState: LoginStateStore
    @EnvironmentObject var feedMeals: FeedMealStore
    @EnvironmentObject var cameraStore: CameraStore
    @State private var isActive: Bool = false
    @State private var selectedMeal: Meal = Meal.meal1
    
    var date: String
    var meals: [Meal]
    var user: User
    
    var isToday: Bool {
        date == Date().toDateString() ? true : false
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(isToday ? "Today" : date)
                    .font(.footnote)
                    .fontWeight(isToday ? .semibold : .regular)
                Spacer()
            }
            .padding(.horizontal, .paddingHorizontal)
            .padding(.bottom, 10)
            
            ZStack {
                NavigationLink(
                    destination: MealDetailView(meal: selectedMeal, user: user, commentList: feedMeals.myMealHistoryCommentList),
                    isActive: $isActive,
                    label: { EmptyView() }
                )
                .isDetailLink(false)
                .opacity(0.0)
                
                if meals.count >= 4 {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 6) {
                            ForEach(meals, id: \.uploadDate) { meal in
                                NavigationLink {
                                    MealDetailView(meal: meal, user: user, commentList: feedMeals.myMealHistoryCommentList)
                                } label: {
                                    ZStack {
                                        Rectangle()
                                            .cornerRadius(15)
                                            .foregroundColor(.white)
                                            .innerShadow(cornerRadius: 15, shadowRadius: 5)
                                        MealTileView(meal: meal)
                                            .frame(width: 100, height: 128)
                                            .cornerRadius(15)
                                        VStack {
                                            Spacer()
                                            HStack {
                                                Spacer()
                                                PlateCountView(plates: meal.plates)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, .paddingHorizontal)
                    }
                } else {
                    HStack(alignment: .center, spacing: 6) {
                        ForEach(meals, id: \.uploadDate) { meal in
                            ZStack {
                                Rectangle()
                                    .cornerRadius(15)
                                    .foregroundColor(.white)
                                    .innerShadow(cornerRadius: 15, shadowRadius: 5)
                                MealTileView(meal: meal)
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .frame(height: 128)
                                    .cornerRadius(15)
                                    .onTapGesture {
                                        selectedMeal = meal
                                        isActive = true
                                    }
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        PlateCountView(plates: meal.plates)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, .paddingHorizontal)
                }
            }
        }
        .padding(.bottom, 18)
    }
}

struct DailyMealCellView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
