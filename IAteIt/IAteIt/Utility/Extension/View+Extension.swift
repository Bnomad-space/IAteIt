//
//  View+Extension.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/04/14.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil
        )
    }
    
    func configSimpleListRow() -> some View {
        self
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
    }
    
    func innerShadow(cornerRadius: CGFloat, shadowRadius: CGFloat) -> some View {
        modifier(InnerShadowModifier(cornerRadius: cornerRadius, shadowRadius: shadowRadius))
    }
}
