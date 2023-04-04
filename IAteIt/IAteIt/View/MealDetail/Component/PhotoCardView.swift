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
    
    var body: some View {
        ZStack {
            ZStack {
                Rectangle()
                    .aspectRatio(1, contentMode: .fit)
                Image(plate.imageUrl)
                    .resizable()
                    .scaledToFill()
                    .layoutPriority(-1)
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
