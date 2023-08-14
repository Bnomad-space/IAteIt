//
//  User.swift
//  IAteIt
//
//  Created by 박성수 on 2023/03/06.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    var nickname: String // Eng only, Must be unique, no blank space
    var profileImageUrl: String? // profileImageUrl nil이라면, systemName으로 Image 넣어주어야 함
    var blockedId: [String]?
}

extension User {
    static let users: [User] = [
        User(id: "user1", nickname: "rain", profileImageUrl: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80"),
        User(id: "user2", nickname: "ThisfromHero")
    ]
    
}
