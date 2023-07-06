//
//  CommentView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/23.
//

import SwiftUI

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
                    AsyncImage(url: URL(string: userImage)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .layoutPriority(-1)
                            .frame(width: profilePicSize, height: profilePicSize)
                    } placeholder: {
                        Color(UIColor.systemGray5)
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
                        .foregroundColor(Color.black)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(comment.uploadDate.toTimeString())
                        .foregroundColor(Color.black)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Text(comment.comment)
                    .foregroundColor(Color.black)
                    .font(.subheadline)
            }
            Spacer()
        }
    }
}
