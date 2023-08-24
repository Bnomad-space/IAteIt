//
//  PhotoCardView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/23.
//

import SwiftUI
import NukeUI

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
                    LazyImage(url: url) { state in
                        if let image = state.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .layoutPriority(-1)
                                .cornerRadius(photoCorner)
                        } else if state.error != nil {
                            PlateImageErrorView(iconSize: iconSize)
                        } else {
                            Color(UIColor.systemGray6)
                        }
                    }
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
