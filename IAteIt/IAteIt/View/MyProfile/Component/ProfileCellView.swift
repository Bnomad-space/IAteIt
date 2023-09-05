//
//  ProfileCellView.swift
//  IAteIt
//
//  Created by Youngwoong Choi on 2023/04/08.
//

import SwiftUI
import Kingfisher

struct ProfileCellView: View {
    @State private var error: KingfisherError?
    
    let profileImgSize: CGFloat = 120
    var user: User
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 18) {
                if let imageUrl = user.profileImageUrl {
                    KFImage(URL(string: imageUrl)!)
                        .onFailure { error in
                            self.error = error
                        }
                        .placeholder {
                            ProfileImageErrorView(error: $error, size: profileImgSize)
                        }
                        .cancelOnDisappear(true)
                        .circleImage(imageSize: profileImgSize)
                        .shadow(color: .black.opacity(0.20), radius: 10, x: 4, y: 4)
                } else {
                    ProfileImageDefaultView(size: profileImgSize)
                        .shadow(color: .black.opacity(0.20), radius: 10, x: 4, y: 4)
                }
                
                Text(user.nickname)
                    .font(.headline)
            }
            Spacer()
        }
    }
}

struct ProfileCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCellView(user: User.users[0])
    }
}
