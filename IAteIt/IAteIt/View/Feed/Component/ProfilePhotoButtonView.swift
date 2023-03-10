//
//  ProfilePhotoButtonView.swift
//  IAteIt
//
//  Created by Beone on 2023/03/09.
//

import SwiftUI

struct ProfilePhotoButtonView: View {
    
    var profileInfo: TempFeedHeader //TODO: 프로필 데이터 수정
    
    var body: some View {
        Button {
            //TODO: 프로필 내비게이션
        } label: {
            ZStack{
                Rectangle()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 28)
                Image(profileInfo.profileImage)
                    .resizable()
                    .scaledToFill()
                    .layoutPriority(-1)
                    .frame(width: 28, height: 28)
            }
            .clipped()
            .cornerRadius(14)
            .padding([.top], 3)
        }
    }
}
