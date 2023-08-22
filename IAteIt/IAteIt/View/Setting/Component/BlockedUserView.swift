//
//  BlockedUserView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/08/22.
//

import SwiftUI

struct BlockedUserView: View {
    let profilePicSize: CGFloat = 36
    var user: User
    
    var body: some View {
        HStack(spacing: 12) {
            if let userImage = user.profileImageUrl {
                CacheAsyncImage(url: URL(string: userImage)!) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .circleImage(imageSize: profilePicSize)
                    case .failure(_):
                        Image(systemName: "exclamationmark.circle")
                            .circleImage(imageSize: profilePicSize)
                    case .empty:
                        Color(UIColor.systemGray6)
                            .frame(width: profilePicSize, height: profilePicSize)
                            .clipShape(Circle())
                    @unknown default:
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .circleImage(imageSize: profilePicSize)
                            .foregroundColor(Color(UIColor.systemGray3))
                    }
                }
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: profilePicSize, height: profilePicSize)
                    .foregroundColor(Color(UIColor.systemGray3))
            }
            
            Text(user.nickname)
                .font(.subheadline)
                .fontWeight(.semibold)
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color(UIColor.systemGray2))
            })
        }
    }
}

struct BlockedUserView_Previews: PreviewProvider {
    static var previews: some View {
        BlockedUserView(user: User.users[0])
    }
}
