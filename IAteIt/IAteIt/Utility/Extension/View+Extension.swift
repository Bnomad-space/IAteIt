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
}
