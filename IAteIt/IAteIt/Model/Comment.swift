//
//  Comment.swift
//  IAteIt
//
//  Created by 박성수 on 2023/03/06.
//

import Foundation

struct Comment: Identifiable, Codable, Hashable {
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
        Comment(id: UUID().uuidString, userId: "user2", mealId: "meal2", comment: "This is awful", uploadDate: Date()),
        Comment(id: UUID().uuidString, userId: "user1", mealId: "meal3", comment: "무플방지", uploadDate: Date()),
        Comment(id: UUID().uuidString, userId: "user2", mealId: "meal3", comment: "두번째 코멘트 테스트", uploadDate: Date())
    ]
}
