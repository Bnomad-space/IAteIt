//
//  Meal.swift
//  IAteIt
//
//  Created by 박성수 on 2023/03/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Meal: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var userId: String
    var location: String?
    var caption: String?
    var uploadDate: Date
    var plates: [Plate]
    var comments: [Comment]?
}

extension Meal {
    static let meals = [
        Meal(id: "meal1", userId: "user1", uploadDate: Date()-60, plates: [Plate.plates[0], Plate.plates[1]], comments: [Comment.comments[0]]),
        Meal(id: "meal2", userId: "user2", uploadDate: Date()-60*60, plates: [Plate.plates[2]], comments: [Comment.comments[1], Comment.comments[2]]),
        Meal(id: "meal3", userId: "user1", location: "맥도날드", caption: "맥모닝 맛있다", uploadDate: Date()-60*60*4, plates: [Plate.plates[3], Plate.plates[4]], comments: [Comment.comments[3], Comment.comments[4]]),
        Meal(id: "meal4", userId: "user2", uploadDate: Date()-60*60*12, plates: [Plate.plates[5]])
    ]
    
    static let meal1 = Meal(id: "meal1", userId: "user1", location: "New York", caption: "A tasty dinner", uploadDate: Date(timeIntervalSinceNow: -173600), plates: [Plate.plate2], comments: [])
    
    static let meal1a = Meal(id: "meal1a", userId: "user1", location: "New York", caption: "A tasty dinner", uploadDate: Date(timeIntervalSinceNow: -293600), plates: [Plate.plate1], comments: [])

    static let meal1b = Meal(id: "meal1b", userId: "user1", location: "New York", caption: "A tasty dinner", uploadDate: Date(timeIntervalSinceNow: -3600), plates: [Plate.plate2, Plate.plate4, Plate.plate5, Plate.plate6], comments: [])

    static let meal1c = Meal(id: "meal1c", userId: "user1", location: "New York", caption: "A tasty dinner", uploadDate: Date(timeIntervalSinceNow: -3600), plates: [Plate.plate1], comments: [])

    static let meal1d = Meal(id: "meal1d", userId: "user1", location: "New York", caption: "A tasty dinner", uploadDate: Date(timeIntervalSinceNow: -3600), plates: [Plate.plate2], comments: [])

    
    static let meal2 = Meal(id: "meal2", userId: "user1", location: "Paris", caption: "French cuisine", uploadDate: Date(timeIntervalSinceNow: -27200), plates: [Plate.plate2, Plate.plate3], comments: [])

    static let meal2a = Meal(id: "meal2a", userId: "user1", location: "Paris", caption: "French cuisine", uploadDate: Date(timeIntervalSinceNow: -27200), plates: [Plate.plate2, Plate.plate3], comments: [])

    static let meal2b = Meal(id: "meal2b", userId: "user1", location: "Paris", caption: "French cuisine", uploadDate: Date(timeIntervalSinceNow: -507200), plates: [Plate.plate2, Plate.plate3], comments: [])

    static let meal3 = Meal(id: "meal3", userId: "user2", location: "Tokyo", caption: "Sushi time", uploadDate: Date(timeIntervalSinceNow: -2500800), plates: [Plate.plate4, Plate.plate5, Plate.plate6], comments: [])
    
    static let meal4 = Meal(id: "meal3", userId: "user2", location: "Tokyo", caption: "Sushi time", uploadDate: Date(timeIntervalSinceNow: -2500800), plates: [Plate.plate7, Plate.plate8, Plate.plate9, Plate.plate10, Plate.plate11, Plate.plate12], comments: [])
    
    static let meal5 = Meal(id: "meal3", userId: "user2", location: "Tokyo", caption: "Sushi time", uploadDate: Date(), plates: [Plate.plate7, Plate.plate8, Plate.plate9, Plate.plate10, Plate.plate11, Plate.plate12], comments: [])

    
    static let mealsByUser = [meal1, meal1a, meal1b, meal1c, meal1d, meal2, meal2a, meal2b, meal3, meal4, meal5]
}
