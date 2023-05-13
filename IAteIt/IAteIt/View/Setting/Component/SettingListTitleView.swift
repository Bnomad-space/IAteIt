//
//  SettingListTitleView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/05/13.
//

import SwiftUI

struct SettingListTitleView: View {
    var title: SettingTitle
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 44)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.10), radius: 10, x: 4, y: 4)
            HStack {
                Image(systemName: title.symbol)
                Text(title.text)
                Spacer()
                if title.isNavigation {
                    Image(systemName: "chevron.right")
                        .font(.subheadline)
                        .foregroundColor(Color(UIColor.systemGray3))
                }
            }
            .font(.body)
            .foregroundColor(title.textColor)
            .padding(.horizontal, .paddingHorizontal)
        }
    }
}

struct SettingListTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SettingListTitleView(title: SettingTitleData().list[0])
    }
}
