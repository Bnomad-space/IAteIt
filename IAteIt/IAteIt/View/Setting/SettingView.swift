//
//  SettingView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/05/12.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var loginState: LoginStateModel
    @State private var isShowingDeleteAccountAlert = false
    
    var body: some View {
        List {
            Section {
                NavigationLink(destination: {
                    EditProfileView()
                }, label: {
                    SettingListTitleView(text: "Edit Profile", symbol: "person", color: .black)
                })
            }
            Section(header: Text("Dangerous Area")) {
                Button(action: {
                    isShowingDeleteAccountAlert = true
                }, label: {
                    SettingListTitleView(text: "Delete Account", symbol: "trash", color: .red)
                })
            }
        }
        .listStyle(.plain)
        .navigationTitle("Settings")
        .alert("Delete Account", isPresented: $isShowingDeleteAccountAlert, actions: {
            Button("Delete", role: .destructive, action: {
                loginState.deleteAccount()
            })
        }, message: {
            Text("Are you sure you want to permanently delete your account and all your data?\nIf you wish to continue with your account deletion, please click “Delete” below. This action is irreversible.")
        })
        .alert("Account Deletion Completed", isPresented: self.$loginState.isShowingDeleteAccountCompleteAlert, actions: {
            Button("OK", role: .cancel, action: {
                // TODO: feed로 나가기
                loginState.checkLoginUser()
            })
        }, message: {
            Text("Your account have been deleted successfully.")
        })
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
