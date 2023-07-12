//
//  MealDetailTopView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/04/04.
//

import SwiftUI

struct MealDetailTopView: View {
    @ObservedObject var commentBar: CommentBar
    @Binding var isMyMeal: Bool
    @Binding var isTodayMeal: Bool
    
    var meal: Meal
    
    var body: some View {
        VStack(alignment: .center, spacing: 6) {
            HStack {
                Spacer()
                Text(meal.uploadDate.timeAgoDisplay())
                    .font(.footnote)
                    .foregroundColor(Color(UIColor.systemGray))
            }
            if isMyMeal && isTodayMeal {
                Button(action: {
                    commentBar.type = .caption
                    commentBar.input = meal.caption ?? ""
                }, label: {
                    if let caption = meal.caption {
                        Text(caption)
                            .font(.headline)
                            .foregroundColor(.black)
                    } else {
                        Text("Add a caption")
                            .font(.headline)
                            .foregroundColor(Color(.systemGray3))
                    }
                })
            } else {
                if let caption = meal.caption {
                    Text(caption)
                        .font(.headline)
                        .foregroundColor(.black)
                }
            }
            if isMyMeal && isTodayMeal {
                Button(action: {
                    commentBar.type = .location
                    commentBar.input = meal.location ?? ""
                }, label: {
                    if let location = meal.location {
                        HStack(alignment: .center, spacing: 4) {
                            Image(systemName: "location.fill")
                            Text(location)
                        }
                        .font(.subheadline)
                        .foregroundColor(.black)
                    } else {
                        HStack(alignment: .center, spacing: 4) {
                            Image(systemName: "location.fill")
                            Text("Add location")
                        }
                        .font(.footnote)
                        .foregroundColor(Color(.systemGray3))
                    }
                })
            } else {
                if let location = meal.location {
                    HStack(alignment: .center, spacing: 4) {
                        Image(systemName: "location.fill")
                        Text(location)
                    }
                    .font(.subheadline)
                    .foregroundColor(.black)
                }
            }
        }
    }
}
