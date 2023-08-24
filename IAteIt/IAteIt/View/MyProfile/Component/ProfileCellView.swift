//
//  ProfileCellView.swift
//  IAteIt
//
//  Created by Youngwoong Choi on 2023/04/08.
//

import SwiftUI
import NukeUI

struct ProfileCellView: View {
    let profileImgSize: CGFloat = 120
    var user: User
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 18) {
                if let imageUrl = user.profileImageUrl {
                    LazyImage(url: URL(string: imageUrl)!) { state in
                        if let image = state.image {
                            image
                                .circleImage(imageSize: profileImgSize)
                        } else if state.error != nil {
                            Image(systemName: "exclamationmark.circle")
                                .circleImage(imageSize: profileImgSize)
                                .foregroundColor(Color(UIColor.systemGray2))
                        } else {
                            Image(systemName: "person.crop.circle")
                                .circleImage(imageSize: profileImgSize)
                                .foregroundColor(Color(UIColor.systemGray2))
                        }
                    }
                    .shadow(color: .black.opacity(0.20), radius: 10, x: 4, y: 4)
                    
                } else {
                    Image(systemName: "person.crop.circle")
                        .circleImage(imageSize: profileImgSize)
                        .foregroundColor(Color(UIColor.systemGray2))
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
