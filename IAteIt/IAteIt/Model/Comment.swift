//
//  Comment.swift
//  IAteIt
//
//  Created by 박성수 on 2023/03/06.
//

import Foundation

struct Comment: Identifiable, Codable {
    let id: String
    let plateId: String
    let ownerId: String
    var comment: String
    let commentTimestamp: Date
    
}

extension Comment {
    static let comments: [Comment] = [
        Comment(id: UUID().uuidString, plateId: "plate1", ownerId: "123", comment: "This is great", commentTimestamp: Date()),
        Comment(id: UUID().uuidString, plateId: "plate2", ownerId: "456", comment: "This is awful", commentTimestamp: Date())
        
    ]
}
