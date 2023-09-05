//
//  ProfilePhotoButtonView.swift
//  IAteIt
//
//  Created by Beone on 2023/03/09.
//

import SwiftUI
import Kingfisher

struct ProfilePhotoButtonView: View {
    @ObservedObject var loginState: LoginStateModel
    @State private var error: KingfisherError?
    
    let profilePicSize: CGFloat = 28
    
    var body: some View {
            ZStack{
                if let profileImageUrl = loginState.user?.profileImageUrl {
                    Rectangle()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: profilePicSize, height: profilePicSize)
                        .foregroundColor(.white)
                    KFImage.url(URL(string: profileImageUrl)!)
                        .resizable()
                        .onFailure { error in
                            self.error = error
                        }
                        .placeholder {
                            ProfileImageErrorView(error: $error, size: profilePicSize)
                        }
                        .cancelOnDisappear(true)
                        .scaledToFill()
                        .layoutPriority(-1)
                        .frame(width: profilePicSize, height: profilePicSize)
                } else {
                    ProfileImageDefaultView(size: profilePicSize)
                }
            }
            .clipped()
            .cornerRadius(profilePicSize/2)
            .padding([.top], 3)
        }
}
