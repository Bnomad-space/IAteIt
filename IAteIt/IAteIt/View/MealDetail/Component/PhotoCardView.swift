//
//  PhotoCardView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/23.
//

import SwiftUI

struct PhotoCardView: View {
    var plate: Plate
    
    let photoCorner: CGFloat = 20
    let iconSize: CGFloat = 48
    
    var body: some View {
        ZStack {
            ZStack {
                Rectangle()
                    .aspectRatio(1, contentMode: .fit)
                    .cornerRadius(photoCorner)
                    .foregroundColor(.white)
                    .innerShadow(cornerRadius: photoCorner, shadowRadius: 10)
                
                if let url = URL(string: plate.imageUrl) {
                    CacheAsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .layoutPriority(-1)
                                .cornerRadius(photoCorner)
                        case .failure(_):
                            PlateImageErrorView(iconSize: iconSize)
                        case .empty:
                            Color(UIColor.systemGray6)
                        @unknown default:
                            PlateImageErrorView(iconSize: iconSize)
                        }
                    }
                }
            }
            .clipped()
            .cornerRadius(photoCorner)
            
            VStack {
                HStack {
                    Spacer()
                    TagOnPhotoView(tagText: plate.uploadDate.toTimeString())
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct PhotoCardView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCardView(plate: Plate.plates[3])
    }
}
