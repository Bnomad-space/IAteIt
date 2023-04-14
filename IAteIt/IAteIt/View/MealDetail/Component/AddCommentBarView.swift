//
//  AddCommentBarView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/24.
//

import SwiftUI

struct AddCommentBarView: View {
    @ObservedObject var commentBar: CommentBar
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 43)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.10), radius: 20, x: 4, y: 4)
                HStack {
                    TextField(commentBar.type.commentBarPlaceholder(), text: $commentBar.input)
                        .font(.body)
                        .focused($isFocused)
                        .onChange(of: commentBar.type) { type in
                            if type == .caption || type == .location {
                                isFocused = true
                            }
                        }
                        .onChange(of: isFocused) { _ in
                            if !isFocused && commentBar.type != CommentBarType.comment {
                                commentBar.input = ""
                                commentBar.type = CommentBarType.comment
                            }
                        }
                    Spacer()
                    Button(action: {
                        // TODO: commentBar.type에 따라 commentBar.input을 코멘트/캡션/장소에 저장
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
        AddCommentBarView(commentBar: CommentBar())
    }
}
