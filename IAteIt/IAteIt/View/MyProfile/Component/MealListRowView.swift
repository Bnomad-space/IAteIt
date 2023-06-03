//
//  MealListRowView.swift
//  IAteIt
//
//  Created by Youngwoong Choi on 2023/04/10.
//

import SwiftUI

struct MealListRowView: View {
    
    let mealsInADay: [Meal]
    
    var body: some View {
        if mealsInADay.count >= 4 {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center) {
                    ForEach(mealsInADay, id: \.uploadDate) { meal in
                        MealTileView(meal: meal)
                            .frame(width: 100, height: 125)
                            .cornerRadius(15)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 15)
            }
        } else {
            HStack(alignment: .center) {
                ForEach(mealsInADay, id: \.uploadDate) { meal in
                    MealTileView(meal: meal)
                        .frame(height: 125)
                        .cornerRadius(15)
                        .clipped()
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 15)

        }
    }
}


struct MealListRowView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
