//
//  MealTileView.swift
//  IAteIt
//
//  Created by CHEIL on 2023/05/19.
//

import SwiftUI
import NukeUI

struct MealTileView: View {
    let meal: Meal
    let iconSize: CGFloat = 48
    
    var body: some View {
        if let url = URL(string: meal.plates[0].imageUrl) {
            LazyImage(url: url) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else if state.error != nil {
                    PlateImageErrorView(iconSize: iconSize)
                } else {
                    Color(UIColor.systemGray6)
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct MealTileView_Previews: PreviewProvider {
    static var previews: some View {
        MealTileView(meal: Meal.meal1)
    }
}
