//
//  MealTileView.swift
//  IAteIt
//
//  Created by CHEIL on 2023/05/19.
//

import SwiftUI

struct MealTileView: View {
    let meal: Meal
    let iconSize: CGFloat = 48
    
    var body: some View {
        if let url = URL(string: meal.plates[0].imageUrl) {
            CacheAsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure(_):
                    PlateImageErrorView(iconSize: iconSize)
                case .empty:
                    Color(UIColor.systemGray6)
                @unknown default:
                    PlateImageErrorView(iconSize: iconSize)
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
