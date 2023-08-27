//
//  ProfileImageErrorView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/08/27.
//

import SwiftUI
import Kingfisher

struct ProfileImageErrorView: View {
    @Binding var error: KingfisherError?
    
    var size: CGFloat
    
    var body: some View {
        if error != nil {
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size, height: size)
                Image(systemName: "exclamationmark.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .foregroundColor(Color(UIColor.systemGray3))
            }
            .clipShape(Circle())
        } else {
            ProfileImageDefaultView(size: size)
        }
    }
}
