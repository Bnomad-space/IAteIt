//
//  CommentView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/23.
//

import SwiftUI

struct CommentView: View {
    let profilePicSize: CGFloat = 36
    
    var comment: Comment
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if let indexOfUser = User.users.firstIndex(where: { $0.id == comment.userId }) {
                
                ZStack {
                    if let userImage = User.users[indexOfUser].profileImageUrl {
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
                            Color.gray
                        }
                    } else {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: profilePicSize, height: profilePicSize)
                            .foregroundColor(.gray)
                    }
                }
                .clipped()
                .cornerRadius(profilePicSize/2)
                .padding([.top], 3)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .bottom, spacing: 8) {
                        Text(User.users[indexOfUser].nickname)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text(comment.uploadDate.toTimeString())
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
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
//        CommentView(comment: Comment.comments[3], userId: User.users[1].id)
        CommentView(comment: Comment.comments[3])
    }
}
