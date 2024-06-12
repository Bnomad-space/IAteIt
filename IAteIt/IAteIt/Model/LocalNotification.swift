//
//  LocalNotification.swift
//  IAteIt
//
//  Created by Eunbee Kang on 6/5/24.
//

import Foundation

struct LocalNotification {
    let content: String
}

extension LocalNotification {
    static let list: [LocalNotification] = [
        LocalNotification(content: "It's mealtime! Share what you're eating at the moment."),
        LocalNotification(content: "Mealtime! Share your current dish or check out what others are enjoying."),
        LocalNotification(content: "Time to eat! Share your meal or discover what others are having."),
        LocalNotification(content: "Feeling Hungry? Share your meal with us or explore what's on others' plates."),
        LocalNotification(content: "Time for a meal! Curious about what others are enjoying?"),
        LocalNotification(content: "It's time to eat! Take a peek at what's on others' plates."),
        LocalNotification(content: "Ready to eat? Show us your delicious meal or snack!"),
        LocalNotification(content: "Time to eat! Want to check out what others have had?"),
        LocalNotification(content: "Feeling hungry? See what's on the menu for others!"),
        LocalNotification(content: "Time for a meal! Explore what others are eating or share your own dish.")
    ]
}
