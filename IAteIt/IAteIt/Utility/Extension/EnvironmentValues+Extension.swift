//
//  EnvironmentValues+Extension.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/05/28.
//

import SwiftUI

struct RootPresentationModeKey: EnvironmentKey {
    static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

extension EnvironmentValues {
    var rootPresentationMode: Binding<RootPresentationMode> {
        get { return self[RootPresentationModeKey.self] }
        set { self[RootPresentationModeKey.self] = newValue }
    }
}

typealias RootPresentationMode = Bool

extension RootPresentationMode {
    public mutating func dismiss() {
        self.toggle()
    }
}
