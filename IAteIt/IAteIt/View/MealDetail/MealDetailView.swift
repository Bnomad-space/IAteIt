//
//  MealDetailView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI

struct MealDetailView: View {
    var meal: Meal
    
    let paddingLR: CGFloat = 16
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    MealDetailTopView(meal: meal)
                    
                    TabView {
                        ForEach(meal.plates, id: \.self) { plate in
                            PhotoCardView(plate: plate)
                        }
                    }
                    .frame(minHeight: 358)
                    .tabViewStyle(.page)
                    
                    if let comments = meal.comments {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(comments, id: \.self) { comment in
                                CommentView(comment: comment, userId: comment.userId)
                            }
                        }
                        .padding([.top], 24)
                    }
                }
            }
            AddCommentBarView()
                .padding([.bottom], 10)
        }
        .padding([.leading, .trailing], paddingLR)
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(meal: Meal.meals[2])
    }
}
