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
    
    let iconSize: CGFloat = 48
    
    var body: some View {
        ZStack {
            Rectangle()
                .aspectRatio(1, contentMode: .fit)
                .foregroundColor(.white)
                .innerShadow(cornerRadius: .photoCorner, shadowRadius: 10)
            
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
            }
        }
        .cornerRadius(.photoCorner)
        .pinchZoom()
    }
}

struct PhotoCardView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCardView(plate: Plate.plates[3])
    }
}
