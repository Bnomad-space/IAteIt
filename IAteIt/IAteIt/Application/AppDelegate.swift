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
      
      UNUserNotificationCenter.current().delegate = self
      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { isAuthorized, error in
          if let error {
              print("[requestAuthorization error]:", error.localizedDescription)
          }
          if isAuthorized {
              self.setLocalNotifications()
          }
      }
      
      UNUserNotificationCenter.current().getNotificationSettings { settings in
          if settings.authorizationStatus == .authorized {
              self.setLocalNotifications()
          } else {
              UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
          }
      }
      
      return true
  }
    
    private func setLocalNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        
        [Weekday.monday, Weekday.wednesday, Weekday.friday].forEach { weekday in
            notificationCenter.addLocalNotificationRequest(hour: 19, day: weekday)
        }
        
        [Weekday.tuesday, Weekday.thursday, Weekday.saturday].forEach { weekday in
            notificationCenter.addLocalNotificationRequest(hour: 12, day: weekday)
        }
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .list, .sound])
    }
}
