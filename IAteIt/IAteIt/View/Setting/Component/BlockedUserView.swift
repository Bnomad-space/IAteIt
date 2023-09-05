//
//  BlockedUserView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/08/22.
//

import SwiftUI
import Kingfisher

struct BlockedUserView: View {
    @EnvironmentObject var loginState: LoginStateModel
    @State private var error: KingfisherError?
    
    let profilePicSize: CGFloat = 36
    var user: User
    
    var body: some View {
        HStack(spacing: 12) {
            if let userImage = user.profileImageUrl {
                KFImage.url(URL(string: userImage)!)
                    .onFailure { error in
                        self.error = error
                    }
                    .placeholder {
                        ProfileImageErrorView(error: $error, size: profilePicSize)
                    }
                    .cancelOnDisappear(true)
                    .circleImage(imageSize: profilePicSize)
            } else {
                ProfileImageDefaultView(size: profilePicSize)
            }
            
            Text(user.nickname)
                .font(.subheadline)
                .fontWeight(.semibold)
            
            Spacer()
            
            Button(action: {
                loginState.deleteBlockedUser(blockedUser: user)
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
