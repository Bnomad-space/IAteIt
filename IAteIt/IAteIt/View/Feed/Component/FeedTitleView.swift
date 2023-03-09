//
//  FeedTitleView.swift
//  IAteIt
//
//  Created by Beone on 2023/03/08.
//

import SwiftUI

struct FeedTitleView: View {
    var body: some View {
        HStack(alignment: .center) {
            Text("I ate It ")
                .fontWeight(.semibold)
            Image(systemName: "fork.knife")
                .tint(.black)
                .font(.body)
        }
    }
}

struct ProfilePhotoView: View {
    
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
