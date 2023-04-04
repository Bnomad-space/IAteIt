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
    var userId: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if let indexOfUser = User.users.firstIndex(where: { $0.id == userId }) {
                
                ZStack {
                    Rectangle()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: profilePicSize, height: profilePicSize)
                    if let image = User.users[indexOfUser].profileImageUrl {
                        Image(image)
                            .resizable()
                            .scaledToFill()
                            .layoutPriority(-1)
                            .frame(width: profilePicSize, height: profilePicSize)
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
        CommentView(comment: Comment.comments[3], userId: User.users[0].id)
    }
}
