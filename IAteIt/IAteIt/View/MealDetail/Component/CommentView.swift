//
//  CommentView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/23.
//

import SwiftUI

struct CommentView: View {
    let profilePicSize: CGFloat = 36
    
    var comment: TempComment
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Rectangle()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: profilePicSize, height: profilePicSize)
                Image(comment.profileImage)
                    .resizable()
                    .scaledToFill()
                    .layoutPriority(-1)
                    .frame(width: profilePicSize, height: profilePicSize)
            }
            .clipped()
            .cornerRadius(profilePicSize/2)
            .padding([.top], 3)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .bottom, spacing: 8) {
                    Text(comment.nickname)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(comment.time)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Text(comment.comment)
                    .font(.subheadline)
            }
            
            Spacer()
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(comment: TempCommentData().list[0])
    }
}
