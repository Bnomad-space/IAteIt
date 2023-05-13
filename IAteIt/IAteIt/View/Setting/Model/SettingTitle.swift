//
//  SettingTitle.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/05/12.
//

import SwiftUI

struct SettingTitle: Hashable {
    let text: String
    let symbol: String
    let textColor: Color
    let isNavigation: Bool
}

struct SettingTitleData {
    var list: [SettingTitle] = [
        SettingTitle(text: "Edit Profile", symbol: "person", textColor: .black, isNavigation: true),
        SettingTitle(text: "Delete Account", symbol: "trash", textColor: .red, isNavigation: false)
    ]
}
