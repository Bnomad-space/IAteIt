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
    
    @StateObject var loginState: LoginState = LoginState()
    @StateObject var signUpState: SignUpState = SignUpState()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                FeedView(loginState: loginState, signUpState: signUpState)
            }
        }
    }
}
