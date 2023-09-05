//
//  MealTileView.swift
//  IAteIt
//
//  Created by CHEIL on 2023/05/19.
//

import SwiftUI
import Kingfisher

struct MealTileView: View {
    let meal: Meal
    let iconSize: CGFloat = 48
    
    @State private var error: KingfisherError?
    
    var body: some View {
        if let url = URL(string: meal.plates[0].imageUrl) {
            KFImage.url(url)
                .resizable()
                .onFailure { error in
                    self.error = error
                }
                .placeholder {
                    PlateImageErrorView(error: $error, iconSize: iconSize)
                }
                .cancelOnDisappear(true)
                .scaledToFill()
                .buttonStyle(PlainButtonStyle())
        }
    }
}

struct MealTileView_Previews: PreviewProvider {
    static var previews: some View {
        MealTileView(meal: Meal.meal1)
    }
}
