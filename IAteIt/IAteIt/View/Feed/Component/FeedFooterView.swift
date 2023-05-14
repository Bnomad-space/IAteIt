//
//  FeedFooterView.swift
//  IAteIt
//
//  Created by Beone on 2023/03/08.
//

import SwiftUI

struct FeedFooterView: View {
    var meal: Meal
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                if let caption = meal.caption {
                    Text(caption)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                if meal.comments?.count ?? 0 > 0 {
                    Text("View all \(meal.comments?.count ?? 0) comments")
                        .font(.footnote)
                        .fontWeight(.regular)
                        .foregroundColor(.gray)
                } else {
                    Text("Write first comment!")
                        .font(.footnote)
                        .fontWeight(.regular)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
    }
}

struct FeedFooterView_Previews: PreviewProvider {
    static var previews: some View {
        FeedFooterView(meal: Meal.meals[2])
    }
}
