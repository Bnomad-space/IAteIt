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
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                FeedView(loginState: loginState, feedMeals: feedMeals)
            }
        }
    }
}
