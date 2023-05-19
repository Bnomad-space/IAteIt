//
//  MealTileView.swift
//  IAteIt
//
//  Created by CHEIL on 2023/05/19.
//

import SwiftUI

struct MealTileView: View {
    let meal = Meal.meal1
    
    var body: some View {
        
        Image("\(meal.plates[0].imageUrl)")
            .resizable()
            .scaledToFit()
            .cornerRadius(15)
            .overlay(alignment: .bottomTrailing) {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 30, height: 30, alignment: .bottomTrailing)
                    .foregroundColor(.black)
                    .opacity(0.6)
                    .padding()
                Text("+\(meal.plates.count)")
                    .font(.footnote)
                    .foregroundColor(.white)
            }
        
    }
}

struct MealTileView_Previews: PreviewProvider {
    static var previews: some View {
        MealTileView()
    }
}
