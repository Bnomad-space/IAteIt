//
//  MealListView.swift
//  IAteIt
//
//  Created by Youngwoong Choi on 2023/03/12.
//

import SwiftUI

struct MealListView: View {
    
    let paddingLR: CGFloat = 16
    let mealsByDateSorted = Dictionary(grouping: Meal.mealsByUser) { $0.uploadDate.toDateString() }
        .sorted { $0.key > $1.key }
    
    var body: some View {
        List {
            ForEach(mealsByDateSorted, id: \.key) { (date, meals) in
                Section {
                    MealListRowView(mealsInADay: meals)
                } header: {
                    if date == Date().toDateString() {
                        Text("Today")
                    } else {
                        Text(date)
                    }
                }
            }
        }
        .listStyle(.plain) // row 마다 좌우 margin 다른 부분 수정 필요
    }
}

struct DailyMealCellView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView()
    }
}
