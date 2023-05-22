//
//  MealTileView.swift
//  IAteIt
//
//  Created by CHEIL on 2023/05/19.
//

import SwiftUI

struct MealTileView: View {
    let meal: Meal
    let width: CGFloat?
    let height: CGFloat?
    
    var body: some View {
        Image("\(meal.plates[0].imageUrl)")
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height, alignment: .center)
            .clipped()
            .cornerRadius(15)
            .overlay(alignment: .bottomTrailing) {
                if meal.plates.count >= 4 {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 30, height: 30, alignment: .bottomTrailing)
                        .foregroundColor(.black)
                        .opacity(0.6)
                        .padding()
                    Text("+\(meal.plates.count - 1)")
                        .font(.footnote)
                        .foregroundColor(.white)
                }
            }
    }
}

struct MealTileView_Previews: PreviewProvider {
    static var previews: some View {
        MealTileView(meal: Meal.meal1, width: 100, height: 125)
    }
}
