//
//  PhotoCardView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/23.
//

import SwiftUI
import Kingfisher

struct PhotoCardView: View {
    @State private var error: KingfisherError?
    
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
                    KFImage.url(url)
                        .resizable()
                        .onFailure { error in
                            self.error = error
                        }
                        .placeholder {
                            PlateImageErrorView(error: $error, iconSize: iconSize)
                        }
                        .cancelOnDisappear(true)
                        .scaledToFill()
                        .layoutPriority(-1)
                        .cornerRadius(photoCorner)
                }
            }
            .clipped()
            .cornerRadius(photoCorner)
        }
    }
}

struct PhotoCardView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCardView(plate: Plate.plates[3])
    }
}
