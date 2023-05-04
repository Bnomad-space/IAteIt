//
//  ProfilePhotoButtonView.swift
//  IAteIt
//
//  Created by Beone on 2023/03/09.
//

import SwiftUI

struct ProfilePhotoButtonView: View {
    @ObservedObject var loginState: LoginStateModel
    var profileInfo: TempFeedHeader //TODO: 프로필 데이터 수정
    let profilePicSize: CGFloat = 28
    
    var body: some View {
//        Button {
//            //TODO: 프로필 내비게이션
//        } label: {
            ZStack{
                if let profileImageUrl = loginState.user?.profileImageUrl {
                    Rectangle()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: profilePicSize, height: profilePicSize)
                    AsyncImage(url: URL(string: profileImageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .layoutPriority(-1)
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
        }
//    }
}
