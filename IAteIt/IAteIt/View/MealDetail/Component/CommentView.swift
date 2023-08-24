//
//  CommentView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/23.
//

import SwiftUI
import NukeUI

struct CommentView: View {
    let profilePicSize: CGFloat = 36
    var user: User
    var comment: Comment
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                if let userImage = user.profileImageUrl {
                    Rectangle()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: profilePicSize, height: profilePicSize)
                        .foregroundColor(.white)
                    LazyImage(url: URL(string: userImage)!) { state in
                        if let image = state.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .layoutPriority(-1)
                        } else if state.error != nil {
                            Image(systemName: "exclamationmark.circle")
                                .resizable()
                                .frame(width: profilePicSize, height: profilePicSize)
                                .foregroundColor(Color(UIColor.systemGray3))
                        } else {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: profilePicSize, height: profilePicSize)
                                .foregroundColor(Color(UIColor.systemGray3))
                        }
                    }
                    .frame(width: profilePicSize, height: profilePicSize)
                    
                } else {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: profilePicSize, height: profilePicSize)
                        .foregroundColor(Color(UIColor.systemGray3))
                }
            }
            .clipped()
            .cornerRadius(profilePicSize/2)
            .padding([.top], 3)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .bottom, spacing: 8) {
                    Text(user.nickname)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(comment.uploadDate.timeAgoDisplay())
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
        CommentView(user: User.users[0], comment: Comment.comments[3])
    }
}
