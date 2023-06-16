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
        ZStack {
            Button {
                print("\(meal.plates[0].imageUrl)")
            } label: {
                Rectangle()
                    .foregroundColor(.clear)
                    .contentShape(Rectangle())
                    .overlay {
                        Image("\(meal.plates[0].imageUrl)")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Rectangle())
                            .overlay(alignment: .bottomTrailing) {
                                if meal.plates.count > 1 {
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
        }
    }
}

struct MealTileView_Previews: PreviewProvider {
    static var previews: some View {
        MealTileView(meal: Meal.meal1)
    }
}
