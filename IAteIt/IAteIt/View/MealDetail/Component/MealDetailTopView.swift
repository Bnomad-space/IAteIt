//
//  MealDetailTopView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/04/04.
//

import SwiftUI

struct MealDetailTopView: View {
    var meal: Meal
    
    var body: some View {
        VStack(alignment: .center, spacing: 6) {
            HStack {
                Spacer()
                Text(meal.uploadDate.timeAgoDisplay())
                    .font(.footnote)
                    .foregroundColor(Color(UIColor.systemGray))
            }
            if let caption = meal.caption {
                Text(caption)
                    .font(.headline)
            }
            if let location = meal.location {
                HStack(alignment: .center, spacing: 4) {
                    Image(systemName: "location.fill")
                    Text(location)
                }
                .font(.subheadline)
            }
        }
    }
}

struct MealDetailTopView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailTopView(meal: Meal.meals[2])
    }
}
