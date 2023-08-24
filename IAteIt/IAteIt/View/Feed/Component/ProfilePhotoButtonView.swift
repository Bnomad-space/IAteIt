//
//  ProfilePhotoButtonView.swift
//  IAteIt
//
//  Created by Beone on 2023/03/09.
//

import SwiftUI
import NukeUI

struct ProfilePhotoButtonView: View {
    @ObservedObject var loginState: LoginStateModel
    let profilePicSize: CGFloat = 28
    
    var body: some View {
            ZStack{
                if let profileImageUrl = loginState.user?.profileImageUrl {
                    Rectangle()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: profilePicSize, height: profilePicSize)
                        .foregroundColor(.white)
                    LazyImage(url: URL(string: profileImageUrl)!) { state in
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
        }
}
