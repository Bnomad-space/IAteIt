//
//  UNUserNotificationCenter+Extension.swift
//  IAteIt
//
//  Created by Eunbee Kang on 6/6/24.
//

import Foundation
import UserNotifications

@frozen enum Weekday: Int {
    case sunday = 1
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}

extension UNUserNotificationCenter {
    func addLocalNotificationRequest(hour: Int, day: Weekday) {
        guard let message = LocalNotification.list.randomElement()?.content else { return }
        
        let content = UNMutableNotificationContent()
        content.body = message
        content.sound = .default
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: makeDateComponent(hour: hour, day: day),
            repeats: true
        )
        let request = UNNotificationRequest(
            identifier: makeLocalNotificationId(hour: hour, day: day),
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    private func makeDateComponent(hour: Int, day: Weekday) -> DateComponents {
        var dateComponent = DateComponents()
        dateComponent.calendar = Calendar.current
        dateComponent.weekday = day.rawValue
        dateComponent.hour = hour
        dateComponent.minute = 0
        
        return dateComponent
    }
    
    private func makeLocalNotificationId(hour: Int, day: Weekday) -> String {
        return "LocalNotification_Calendar_\(day)_\(hour)"
    }
}
