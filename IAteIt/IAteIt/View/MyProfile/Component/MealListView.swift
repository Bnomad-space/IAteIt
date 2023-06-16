//
//  MealListView.swift
//  IAteIt
//
//  Created by Youngwoong Choi on 2023/03/12.
//

import SwiftUI

struct MealListView: View {
    
    let mealsByDateSorted = Dictionary(grouping: Meal.mealsByUser) { $0.uploadDate.toDateString() }
        .sorted { $0.value[0].uploadDate > $1.value[0].uploadDate }
    
    let mealsByUserSorted = Meal.mealsByUser.sorted
    
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(mealsByDateSorted, id: \.key) { (date, meals) in
                
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
                
                
                
            }
        }
    }
}

struct DailyMealCellView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView()
    }
}
