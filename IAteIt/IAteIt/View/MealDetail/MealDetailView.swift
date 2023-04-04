//
//  MealDetailView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI

struct MealDetailView: View {
    var tempPlateList = TempPlateData().list
    var tempCommentList = TempCommentData().list
    
    var mealData: Meal = Meal.meals[3]
    
    let paddingLR: CGFloat = 16
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    MealDetailTopView(meal: mealData)
                    
                    TabView {
                        ForEach(mealData.plates, id: \.self) { plate in
                            PhotoCardView(plate: plate)
                        }
                    }
                    .frame(minHeight: 358)
                    .tabViewStyle(.page)
                    
                    if let comments = mealData.comments {
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
        MealDetailView()
    }
}
