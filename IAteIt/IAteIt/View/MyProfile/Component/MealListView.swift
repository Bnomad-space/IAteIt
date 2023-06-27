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
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(feedMeals.myMealHistorySorted, id: \.key) { (date, meals) in
                
                if date == Date().toDateString() {
                    HStack {
                        Text("Today")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                } else {
                    HStack {
                        Text(date)
                            .font(.footnote)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                }
                
                MealListRowView(mealsInADay: meals)
                    .environmentObject(loginState)
            }
        }
    }
}

struct DailyMealCellView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView()
    }
}
