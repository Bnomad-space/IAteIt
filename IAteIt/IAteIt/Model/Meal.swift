//
//  Meal.swift
//  IAteIt
//
//  Created by 박성수 on 2023/03/22.
//

import Foundation

struct Meal: Identifiable, Codable {
    var id: String
    var userId: String
    var location: String?
    var caption: String?
    var uploadDate: Date
    var plates: [Plate]
    var comments: [Comment]?
    
}

extension Meal {
    static let meals = [
        Meal(id: "meal1", userId: "user1", uploadDate: Date(), plates: [Plate.plates[0], Plate.plates[1]], comments: [Comment.comments[0]]),
        Meal(id: "meal2", userId: "user2", uploadDate: Date(), plates: [Plate.plates[2]], comments: [Comment.comments[1], Comment.comments[2]])
    ]
    
    static let meal1 = Meal(id: "meal1", userId: "user1", location: "New York", caption: "A tasty dinner", uploadDate: Date(timeIntervalSinceNow: -3600), plates: [Plate.plate1, Plate.plate2], comments: [])
    
    static let meal2 = Meal(id: "meal2", userId: "user1", location: "Paris", caption: "French cuisine", uploadDate: Date(timeIntervalSinceNow: -7200), plates: [Plate.plate3, Plate.plate4], comments: [])
    
    static let meal3 = Meal(id: "meal3", userId: "user2", location: "Tokyo", caption: "Sushi time", uploadDate: Date(timeIntervalSinceNow: -10800), plates: [Plate.plate5, Plate.plate6], comments: [])
    
    static let mealsByUser = Dictionary(grouping: [meal1, meal2, meal3], by: { $0.userId })
}
