//
//  InnerShadowModifier.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/07/12.
//

import SwiftUI

struct InnerShadowModifier: ViewModifier {
    @State var cornerRadius: CGFloat = 15
    @State var shadowRadius: CGFloat = 5
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color(.white), lineWidth: shadowRadius)
                    .shadow(color: .black.opacity(0.20), radius: shadowRadius, x: 4, y: 4)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .shadow(color: .white.opacity(0.20), radius: shadowRadius, x: -4, y: -4)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            )
    }
}
