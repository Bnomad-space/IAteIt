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
    
    static let meal1 = Meal(userId: "user1", uploadDate: Date(), plates: [], comments: [])
}
