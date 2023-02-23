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
    
    var body: some View {
        
        GeometryReader { metrics in
            let photoWidth = metrics.size.width - paddingLR * 2
            
            ZStack {
                Image("Sample_McMorning")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: photoWidth, height: photoWidth)
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
                        Image(systemName: "plus")
                    }
                    .padding()
                }
            }
            .padding([.leading, .trailing], paddingLR)
        }
    }
}

struct PhotoCardView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCardView(tagLocation: .constant("맥도날드"), tagTime: .constant("07:40"))
    }
}
