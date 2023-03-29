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
    
}

extension User {
    static let users: [User] = [
        User(id: "user1", nickname: "rain", profileImageUrl: "https://cdn.hswstatic.com/gif/google-update.jpg"),
        User(id: "user2", nickname: "ThisfromHero")
    ]
    
}
