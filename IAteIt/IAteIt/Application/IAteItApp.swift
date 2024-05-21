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
    
    @StateObject var loginState: LoginStateStore = LoginStateStore()
    @StateObject var feedMeals: FeedMealStore = FeedMealStore()
    @StateObject var cameraStore = CameraStore()
    @State private var isActive: Bool = false
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                FeedView(isActive: $isActive)
            }
            .accentColor(.black)
            .navigationViewStyle(StackNavigationViewStyle())
            .environment(\.rootPresentationMode, self.$isActive)
            .environmentObject(loginState)
            .environmentObject(feedMeals)
            .environmentObject(cameraStore)
        }
    }
}
