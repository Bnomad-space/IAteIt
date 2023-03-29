//
//  AppDelegate.swift
//  IAteIt
//
//  Created by 박성수 on 2023/03/10.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
      let _ = Firestore.firestore()
      return true
  }
    
}
