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
    
    static let comment1 = Comment(id: "comment1", userId: "user1", mealId: "meal1", comment: "Looks delicious!", uploadDate: Date().addingTimeInterval(-1800)) // 30 minutes ago
    static let comment2 = Comment(id: "comment2", userId: "user2", mealId: "meal1", comment: "I want to try this!", uploadDate: Date().addingTimeInterval(-3600)) // 1 hour ago
    static let comment3 = Comment(id: "comment3", userId: "user3", mealId: "meal2", comment: "Great presentation!", uploadDate: Date().addingTimeInterval(-43200)) // 12 hours ago
    static let comment4 = Comment(id: "comment4", userId: "user1", mealId: "meal3", comment: "Yummy!", uploadDate: Date().addingTimeInterval(-86400)) // 1 day ago
}
