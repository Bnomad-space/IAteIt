//
//  SettingView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/05/12.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var loginState: LoginStateStore
    @State private var isShowingDeleteAccountAlert = false
    @State private var isPresentTermsOfUseWebView = false
    @State private var isPresentPrivacyPolicyWebView = false
    @State private var isDeleted = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    
    var body: some View {
        List {
            // MARK: Personal Section
            Section(header: Text("Personal")) {
                NavigationLink(destination: {
                    EditProfileView()
                }, label: {
                    SettingListTitleView(text: "Edit Profile", symbol: "person", color: .black)
                })
                NavigationLink(destination: {
                    BlockedUsersView()
                }, label: {
                    SettingListTitleView(text: "Blocked Users", symbol: "nosign", color: .black)
                })
                Button(action: {
                    loginState.logout { success in
                        if success {
                            self.rootPresentationMode.wrappedValue.dismiss()
                        } else {
                            // TODO: logout 실패 alert
                        }
                    }
                }, label: {
                    SettingListTitleView(text: "Logout", symbol: "person.badge.minus", color: .black)
                })
            }
            
            // MARK: Information Section
            Section(header: Text("Information")) {
                Button(action: {
                    isPresentTermsOfUseWebView = true
                }, label: {
                    SettingListTitleView(text: "Terms of Use", symbol: "doc.text", color: .black)
                })
                .sheet(isPresented: $isPresentTermsOfUseWebView) {
                    NavigationView {
                        WebView(url: URL(string: Const.URL.termsOfUse.rawValue)!)
                            .navigationTitle("Terms of Use")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
                Button(action: {
                    isPresentPrivacyPolicyWebView = true
                }, label: {
                    SettingListTitleView(text: "Privacy Policy", symbol: "lock.doc", color: .black)
                })
                .sheet(isPresented: $isPresentPrivacyPolicyWebView) {
                    NavigationView {
                        WebView(url: URL(string: Const.URL.privacyPolicy.rawValue)!)
                            .navigationTitle("Privacy Policy")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
            }
            
            // MARK: Dangerous Section
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
        .fullScreenCover(
            isPresented: $isDeleted,
            onDismiss: {
                self.isDeleted = false
                loginState.isShowingDeleteAccountCompleteAlert = loginState.isDeleteAccountCompleteAlertRequired
            }, content: {
                LoginView(loginState: loginState)
            }
        )
        .alert("Delete Account",
               isPresented: $isShowingDeleteAccountAlert,
               actions: {
            Button("Delete",
                   role: .destructive,
                   action: {
                loginState.type = .deleteAccount
                loginState.isAppleLoginRequired = true
                self.isDeleted = true
            }
            )
        }, message: {
            Text("Are you sure you want to permanently delete your account and all your data?\nIf you wish to continue with your account deletion, please click “Delete” below. This action is irreversible.")
        }
        )
        .alert("Account Deletion Completed",
               isPresented: self.$loginState.isShowingDeleteAccountCompleteAlert,
               actions: {
            Button("OK",
                   role: .cancel,
                   action: {
                self.rootPresentationMode.wrappedValue.dismiss()
            }
            )
        }, message: {
            Text("Your account have been deleted successfully.")
        }
        )
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(LoginStateStore())
    }
}
