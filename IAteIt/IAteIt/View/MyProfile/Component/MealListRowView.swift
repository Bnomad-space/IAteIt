//
//  MealListRowView.swift
//  IAteIt
//
//  Created by Youngwoong Choi on 2023/04/10.
//

import SwiftUI

struct MealListRowView: View {
    
    let mealsInADay: [Meal]
    let paddingLR: CGFloat = 16
    let photoCorner: CGFloat = 20
    
    var body: some View {
        if mealsInADay.count >= 4 {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center) {
                    ForEach(mealsInADay, id: \.id) { meal in
                        ZStack{
                            Rectangle()
                            Image("\(meal.plates[0].imageUrl)")
                                .resizable()
                                .scaledToFill()
                        }
                        .frame(minWidth: 100, idealWidth: 100, maxWidth: 100, minHeight: 125, idealHeight: 125, maxHeight: 125, alignment: .top)
                        .clipped()
                    }
                }
            }.frame(height: 128, alignment: .topLeading)
        } else {
            HStack(alignment: .top) {
                ForEach(mealsInADay, id: \.id) { meal in
                    ZStack{
                        Rectangle()
                        Image("\(meal.plates[0].imageUrl)")
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(height: 125, alignment: .center)
                    .clipped()
                }
            }
        }
    }
}


struct MealListRowView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView()
    }
}
