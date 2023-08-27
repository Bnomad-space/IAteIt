//
//  Image+Extension.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/05/28.
//

import SwiftUI
import Kingfisher

extension Image {
    func circleImage(imageSize: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: imageSize, height: imageSize)
            .clipShape(Circle())
   }
}

extension KFImage {
    func circleImage(imageSize: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: imageSize, height: imageSize)
            .clipShape(Circle())
   }
}
