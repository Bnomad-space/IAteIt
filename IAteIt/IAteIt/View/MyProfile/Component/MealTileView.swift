//
//  MealTileView.swift
//  IAteIt
//
//  Created by CHEIL on 2023/05/19.
//

import SwiftUI

struct MealTileView: View {
    let meal: Meal
    
    var body: some View {
        AsyncImage(url: URL(string: meal.plates[0].imageUrl)) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            Color(UIColor.systemGray5)
        }
        .buttonStyle(PlainButtonStyle())
        .overlay(alignment: .bottomTrailing) {
            PlateCountView(plates: meal.plates)
        }
    }
}

struct MealTileView_Previews: PreviewProvider {
    static var previews: some View {
        MealTileView(meal: Meal.meal1)
    }
}
