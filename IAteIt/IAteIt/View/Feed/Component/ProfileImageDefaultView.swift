//
//  ProfileImageDefaultView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/08/27.
//

import SwiftUI

struct ProfileImageDefaultView: View {
    var size: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
            Image(systemName: "person.crop.circle")
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .foregroundColor(Color(UIColor.systemGray3))
        }
        .clipShape(Circle())
    }
}
