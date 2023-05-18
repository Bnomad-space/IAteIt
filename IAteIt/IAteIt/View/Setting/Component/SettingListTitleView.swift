//
//  SettingListTitleView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/05/13.
//

import SwiftUI

struct SettingListTitleView: View {
    var text: String
    var symbol: String
    var color: Color
    
    var body: some View {
        HStack {
            Image(systemName: symbol)
            Text(text)
        }
        .font(.body)
        .foregroundColor(color)
    }
}

struct SettingListTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SettingListTitleView(text: "Edit Profile", symbol: "person", color: .black)
    }
}
