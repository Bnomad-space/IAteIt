//
//  MealListView.swift
//  IAteIt
//
//  Created by Youngwoong Choi on 2023/03/12.
//

import SwiftUI

struct MealListView: View {
    @EnvironmentObject var loginState: LoginStateModel
    @EnvironmentObject var feedMeals: FeedMealModel
    @EnvironmentObject var cameraViewModel: CameraViewModel
    
    var date: String
    var meals: [Meal]
    
    var body: some View {
        VStack(spacing: 0) {
            if date == Date().toDateString() {
                HStack {
                    Text("Today")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.horizontal, .paddingHorizontal)
                .padding(.bottom, 10)
            } else {
                HStack {
                    Text(date)
                        .font(.footnote)
                    Spacer()
                }
                .padding(.horizontal, .paddingHorizontal)
                .padding(.bottom, 10)
            }
            
            MealListRowView(mealsInADay: meals)
                .environmentObject(loginState)
                .environmentObject(feedMeals)
                .environmentObject(cameraViewModel)
        }
        .padding(.bottom, 18)
    }
}

struct DailyMealCellView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
