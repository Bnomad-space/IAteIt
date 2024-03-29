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
    
    @StateObject var loginState: LoginStateModel = LoginStateModel()
    @StateObject var feedMeals: FeedMealModel = FeedMealModel()
    @State private var isActive: Bool = false
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                FeedView(isActive: $isActive)
                    .environmentObject(loginState)
                    .environmentObject(feedMeals)
            }
            .accentColor(.black)
            .navigationViewStyle(StackNavigationViewStyle())
            .environment(\.rootPresentationMode, self.$isActive)
        }
    }
}
