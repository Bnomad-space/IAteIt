//
//  PhotoCardView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/23.
//

import SwiftUI

struct PhotoCardView: View {
    var plate: TempPlate
    
    let photoCorner: CGFloat = 20
    
    var body: some View {
            ZStack {
                ZStack {
                    Rectangle()
                        .aspectRatio(1, contentMode: .fit)
                    Image(plate.image)
                        .resizable()
                        .scaledToFill()
                        .layoutPriority(-1)
                }
                .clipped()
                .cornerRadius(photoCorner)
                
                VStack {
                    HStack {
                        Spacer()
                        Text(plate.time)
                        .font(.footnote)
                        .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .opacity(0.6)
                        )
                    }
                    .padding()
                    
                    Spacer()
                }
            }
    }
}

struct PhotoCardView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCardView(plate: TempPlateData().list[0])
    }
}
