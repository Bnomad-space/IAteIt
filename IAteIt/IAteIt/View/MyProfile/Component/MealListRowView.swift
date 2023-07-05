//
//  MealListRowView.swift
//  IAteIt
//
//  Created by Youngwoong Choi on 2023/04/10.
//

import SwiftUI

struct MealListRowView: View {
    @EnvironmentObject var loginState: LoginStateModel
    
    let mealsInADay: [Meal]
    
    var body: some View {
        if mealsInADay.count >= 4 {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center) {
                    ForEach(mealsInADay, id: \.uploadDate) { meal in
                        MealTileView(meal: meal)
                            .frame(width: 100)
                            .cornerRadius(15)
                            .environmentObject(loginState)
                    }
                }
                .contentShape(Rectangle())
                .padding(.horizontal, .paddingHorizontal)
            }
        } else {
            HStack(alignment: .center, spacing: 6) {
                ForEach(mealsInADay, id: \.uploadDate) { meal in
                    MealTileView(meal: meal)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .cornerRadius(15)
                        .clipped()
                        .environmentObject(loginState)
                }
            }
            .padding(.horizontal, .paddingHorizontal)
        }
    }
}


struct MealListRowView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
