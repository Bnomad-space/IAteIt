//
//  SettingView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/05/12.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var loginState: LoginStateModel
    @EnvironmentObject var feedMeals: FeedMealModel
    @State private var isShowingDeleteAccountAlert = false
    @State private var isPresentWebView = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    
    var body: some View {
        List {
            Section(header: Text("Personal")) {
                NavigationLink(destination: {
                    EditProfileView()
                        .environmentObject(loginState)
                }, label: {
                    SettingListTitleView(text: "Edit Profile", symbol: "person", color: .black)
                })
                NavigationLink(destination: {
                    BlockedUsersView()
                        .environmentObject(loginState)
                }, label: {
                    SettingListTitleView(text: "Blocked Users", symbol: "nosign", color: .black)
                })
            }
            Section(header: Text("Information")) {
                Button(action: {
                    isPresentWebView = true
                }, label: {
                    SettingListTitleView(text: "Terms of Use", symbol: "doc.text", color: .black)
                })
                .sheet(isPresented: $isPresentWebView) {
                    NavigationView {
                        WebView(url: URL(string: Const.URL.termsOfUse.rawValue)!)
                            .navigationTitle("Terms of Use")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
                Button(action: {
                    isPresentWebView = true
                }, label: {
                    SettingListTitleView(text: "Privacy Policy", symbol: "lock.doc", color: .black)
                })
                .sheet(isPresented: $isPresentWebView) {
                    NavigationView {
                        WebView(url: URL(string: Const.URL.privacyPolicy.rawValue)!)
                            .navigationTitle("Privacy Policy")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
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
        .fullScreenCover(isPresented: self.$loginState.isAppleLoginRequired,
            onDismiss: {
                loginState.isShowingDeleteAccountCompleteAlert = loginState.isDeleteAccountCompleteAlertRequired
            }, content: {
                LoginView(loginState: loginState, feedMeals: feedMeals)
        })
        .alert("Delete Account", isPresented: $isShowingDeleteAccountAlert, actions: {
            Button("Delete", role: .destructive, action: {
                loginState.type = .deleteAccount
                loginState.isAppleLoginRequired = true
            })
        }, message: {
            Text("Are you sure you want to permanently delete your account and all your data?\nIf you wish to continue with your account deletion, please click “Delete” below. This action is irreversible.")
        })
        .alert("Account Deletion Completed", isPresented: self.$loginState.isShowingDeleteAccountCompleteAlert, actions: {
            Button("OK", role: .cancel, action: {
                loginState.checkLoginUser()
                self.rootPresentationMode.wrappedValue.dismiss()
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
