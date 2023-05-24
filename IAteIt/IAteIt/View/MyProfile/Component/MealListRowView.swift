//
//  MealListRowView.swift
//  IAteIt
//
//  Created by Youngwoong Choi on 2023/04/10.
//

import SwiftUI

struct MealListRowView: View {
    
    let mealsInADay: [Meal]
    let photoCorner: CGFloat = 20
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {

        if mealsInADay.count >= 4 {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center) {
                    ForEach(mealsInADay, id: \.id) { meal in
                        MealTileView(meal: meal, width: 100, height: 125)
                    }
                }
            }
            .padding()
            .listRowSeparator(.hidden)
        } else {
            HStack(alignment: .top) {
                ForEach(mealsInADay, id: \.id) { meal in
                    MealTileView(meal: meal, width: screenWidth/3, height: 125)

//                    ZStack{
//                        Rectangle()
//                        Image("\(meal.plates[0].imageUrl)")
//                            .resizable()
//                            .scaledToFill()
//                    }
                }
            }
            .padding(.leading, 40)
            .listRowSeparator(.hidden)
        }
    }
}


struct MealListRowView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView()
    }
}
