//
//  MaxCornerRadius.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2024/02/07.
//

import SwiftUI

struct MaxCornerRadius: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 268, height: 50, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(.black, lineWidth: 1)
            )
    }
}
