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
    
}
