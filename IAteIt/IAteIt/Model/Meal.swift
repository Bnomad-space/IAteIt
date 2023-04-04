//
//  Meal.swift
//  IAteIt
//
//  Created by 박성수 on 2023/03/22.
//

import Foundation

struct Meal: Identifiable, Codable, Hashable {
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
        Meal(id: "meal2", userId: "user2", uploadDate: Date(), plates: [Plate.plates[2]], comments: [Comment.comments[1], Comment.comments[2]]),
        Meal(id: "meal3", userId: "user1", location: "맥도날드", caption: "맥모닝 맛있다", uploadDate: Date(), plates: [Plate.plates[3], Plate.plates[4]], comments: [Comment.comments[3], Comment.comments[4]]),
        Meal(id: "meal4", userId: "user2", uploadDate: Date(), plates: [Plate.plates[4]])
    ]
}
