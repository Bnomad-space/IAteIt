//
//  PlateImageErrorView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/07/12.
//

import SwiftUI
import Kingfisher

struct PlateImageErrorView: View {
    @Binding var error: KingfisherError?
    
    var iconSize: CGFloat
    
    var body: some View {
        VStack {
            if error != nil {
                Text("Error!")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(UIColor.systemGray2))
                Image(systemName: "takeoutbag.and.cup.and.straw")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: iconSize)
                    .foregroundColor(Color(UIColor.systemGray3))
            } else {
                Color(UIColor.systemGray6)
            }
        }
    }
}
