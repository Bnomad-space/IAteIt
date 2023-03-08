//
//  PhotoCardView.swift
//  IAteIt
//
//  Created by Beone on 2023/03/07.
//

import SwiftUI

struct FeedPhotoCardView: View {
    
    let profilePicSize: CGFloat = 36
    var PostInfo: TempFeedPhotoCard
    var tempPlateList = TempPlateData().list
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                ZStack {
                    Rectangle()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: profilePicSize, height: profilePicSize)
                    Image(PostInfo.profileImage)
                        .resizable()
                        .scaledToFill()
                        .layoutPriority(-1)
                        .frame(width: profilePicSize, height: profilePicSize)
                }
                .clipped()
                .cornerRadius(profilePicSize/2)
                .padding([.top], 3)
                
                VStack(alignment: .leading) {
                    Text(PostInfo.nickname)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    HStack(alignment: .bottom, spacing: 8) {
                        Text(PostInfo.place)
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text("·")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text(PostInfo.time)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                .padding([.leading], 12)
                .padding([.top], 2)
                
                Spacer()
            }
            .padding([.leading], 16)
        }
    }
}

struct FeedPhotoCardView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
