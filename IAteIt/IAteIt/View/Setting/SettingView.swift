//
//  SettingView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/05/12.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var loginState: LoginStateModel
    
    var body: some View {
        List {
            Section {
                NavigationLink(destination: {
                    EditProfileView()
                        .environmentObject(loginState)
                }, label: {
                    SettingListTitleView(text: "Edit Profile", symbol: "person", color: .black)
                })
            }
            Section(header: Text("Dangerous Area")) {
                SettingListTitleView(text: "Delete Account", symbol: "trash", color: .red)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Settings")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
