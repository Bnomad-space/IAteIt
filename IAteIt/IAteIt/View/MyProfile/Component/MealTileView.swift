//
//  MealTileView.swift
//  IAteIt
//
//  Created by CHEIL on 2023/05/19.
//

import SwiftUI

struct MealTileView: View {
    @EnvironmentObject var loginState: LoginStateModel
    
    let meal: Meal
    
    var body: some View {
        Button {
            print("\(meal.plates[0].imageUrl)")
        } label: {
            AsyncImage(url: URL(string: meal.plates[0].imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 128)
                    .clipped()
            } placeholder: {
                Color(UIColor.systemGray5)
                    .frame(height: 128)
            }
        }
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
