//
//  IAteItApp.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI
import Firebase

@main
struct IAteItApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var loginUser: LoginUser = LoginUser()
    @StateObject var signUpVM: SignUpViewModel = SignUpViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                FeedView(loginUser: loginUser, signUpVM: signUpVM)
            }
        }
    }
}
