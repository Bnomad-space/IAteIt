//
//  SettingView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/05/12.
//

import SwiftUI

struct SettingView: View {
    var titleList = SettingTitleData().list
    
    var body: some View {
        ScrollView {
            VStack {
                NavigationLink(destination: {
                    EditProfileView()
                }, label: {
                    SettingListTitleView(title: titleList[0])
                })
                .padding(.top, 24)
                VStack(alignment: .leading) {
                    Text("DANGEROUS AREA")
                        .font(.caption)
                        .foregroundColor(Color(UIColor.systemGray))
                        .padding(.top)
                        .padding(.horizontal, .paddingHorizontal)
                    SettingListTitleView(title: titleList[1])
                }
            }
            .padding(.horizontal, .paddingHorizontal)
        }
        .navigationTitle("Settings")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
