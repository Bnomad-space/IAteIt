//
//  PhotoCardView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/23.
//

import SwiftUI

struct PhotoCardView: View {
    @Binding var tagLocation: String
    @Binding var tagTime: String
    
    let tagImageLocation = "location"
    let tagImageTime = "clock"
    
    let paddingLR: CGFloat = 16
    let photoCorner: CGFloat = 20
    
    var photoWidth: CGFloat = 0
    
    var body: some View {
            ZStack {
                ZStack {
                    Rectangle()
                        .aspectRatio(1, contentMode: .fit)
                    Image("Sample_McMorning")
                        .resizable()
                        .scaledToFill()
                        .layoutPriority(-1)
                }
                .clipped()
                .cornerRadius(photoCorner)
                
                VStack {
                    HStack {
                        TagOnPhotoView(tagText: $tagLocation, tagImage: tagImageLocation)
                        Spacer()
                        TagOnPhotoView(tagText: $tagTime, tagImage: tagImageTime)
                    }
                    .padding()
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        ZStack {
                            Circle()
                                .opacity(0.6)
                                .frame(width: 36, height: 36)
                            Image(systemName: "plus.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                }
            }
            .padding([.leading, .trailing], paddingLR)
    }
}

struct PhotoCardView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCardView(tagLocation: .constant("맥도날드"), tagTime: .constant("07:40"))
    }
}
