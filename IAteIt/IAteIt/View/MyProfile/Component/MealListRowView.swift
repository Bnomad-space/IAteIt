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
                            .contentShape(Rectangle())
                            .cornerRadius(15)
                    }
                }
                .contentShape(Rectangle())
                .padding(.horizontal)
                Spacer(minLength: 0)
            }.frame(minHeight: 125, idealHeight: 250)
        } else {
            HStack(alignment: .center) {
                ForEach(mealsInADay, id: \.uploadDate) { meal in
                    MealTileView(meal: meal)
                        .frame(height: 125)
                        .contentShape(Rectangle())
                        .cornerRadius(15)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
            
            Spacer(minLength: 0)

        }
    }
}


struct MealListRowView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
