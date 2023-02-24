//
//  PhotoCardView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/23.
//

import SwiftUI

struct PhotoCardView: View {
    var plate: TempPlate
    
    let tagImageLocation = "location"
    let tagImageTime = "clock"
    
    let paddingLR: CGFloat = 16
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
                        TagOnPhotoView(tagText: plate.location, tagImage: tagImageLocation)
                        Spacer()
                        TagOnPhotoView(tagText: plate.time, tagImage: tagImageTime)
                    }
                    .padding()
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            // TODO: 내 포스팅에만 보이기, CameraView(upload) 연결
                        }, label: {
                            ZStack {
                                Circle()
                                    .opacity(0.6)
                                    .frame(width: 36, height: 36)
                                    .tint(.black)
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                                    .foregroundColor(.white)
                            }
                        })
                    }
                    .padding()
                }
            }
            .padding([.leading, .trailing], paddingLR)
    }
}

struct PhotoCardView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCardView(plate: TempPlateData().list[0])
    }
}
