//
//  Comment.swift
//  IAteIt
//
//  Created by 박성수 on 2023/03/06.
//

import Foundation

struct Comment: Identifiable, Codable {
    let id: String
    let userId: String
    let mealId: String
    var comment: String
    let uploadDate: Date
    
}

extension Comment {
    static let comments: [Comment] = [
        Comment(id: UUID().uuidString, userId: "user1", mealId: "meal1", comment: "This is great", uploadDate: Date()),
        Comment(id: UUID().uuidString, userId: "user1", mealId: "meal2", comment: "This is comment From rain", uploadDate: Date()),
        Comment(id: UUID().uuidString, userId: "user2", mealId: "meal2", comment: "This is awful", uploadDate: Date())
    ]
    
}
