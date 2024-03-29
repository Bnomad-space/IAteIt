//
//  AddCommentBarView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/24.
//

import SwiftUI

struct AddCommentBarView: View {
    @ObservedObject var feedMeals: FeedMealModel
    @ObservedObject var commentBar: CommentBar
    @FocusState var isFocused: Bool
    
    @State var meal: Meal
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 43)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.10), radius: 20, x: 4, y: 4)
                HStack {
                    TextField(commentBar.type.placeholder(), text: $commentBar.input)
                        .font(.body)
                        .focused($isFocused)
                        .onChange(of: commentBar.type) { type in
                            if type == .caption || type == .location {
                                isFocused = true
                            }
                        }
                        .onChange(of: isFocused) { _ in
                            if !isFocused && commentBar.type != .comment {
                                commentBar.input = ""
                                commentBar.type = .comment
                            }
                        }
                    Spacer()
                    Button(action: {
                        if commentBar.type == .comment {
                            feedMeals.commentUpload(meal: meal, comment: commentBar.input)
                        } else if commentBar.type == .caption {
                            meal.caption = commentBar.input
                            feedMeals.saveCaption(meal: meal, content: commentBar.input)
                        } else if commentBar.type == .location {
                            meal.location = commentBar.input
                            feedMeals.saveLocation(meal: meal, content: commentBar.input)
                        }
                        isFocused = false
                        commentBar.input = ""
                    }, label: {
                        if commentBar.input.count > 0 {
                            Image(systemName: "paperplane.fill")
                                .tint(.black)
                                .font(.body)
                        } else {
                            Image(systemName: "paperplane")
                                .tint(.black)
                                .font(.body)
                        }
                    })
                    .disabled(commentBar.input.isEmpty)
                }
                .padding([.leading, .trailing], 18)
            }
        }
    }
}

struct AddCommentBarView_Previews: PreviewProvider {
    static var previews: some View {
        AddCommentBarView(feedMeals: FeedMealModel(), commentBar: CommentBar(), meal: Meal.meals[2])
    }
}
