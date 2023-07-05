//
//  MealTileView.swift
//  IAteIt
//
//  Created by CHEIL on 2023/05/19.
//

import SwiftUI

struct MealTileView: View {
    @EnvironmentObject var loginState: LoginStateModel
    @EnvironmentObject var feedMeals: FeedMealModel
    @EnvironmentObject var cameraViewModel: CameraViewModel
    
    let meal: Meal
    
    var body: some View {
        if let user = loginState.user {
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
                .buttonStyle(PlainButtonStyle())
                .overlay(alignment: .bottomTrailing) {
                    PlateCountView(plates: meal.plates)
                }
            }
            .background(
                NavigationLink(destination:
                    MealDetailView(meal: meal, user: user)
                        .environmentObject(cameraViewModel)
                        .environmentObject(loginState)
                        .environmentObject(feedMeals)
                ) {
                    Text("")
                }
                .opacity(0)
            )
        }
    }
}

struct MealTileView_Previews: PreviewProvider {
    static var previews: some View {
        MealTileView(meal: Meal.meal1)
    }
}
