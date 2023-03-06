//
//  User.swift
//  IAteIt
//
//  Created by 박성수 on 2023/03/06.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    var userId: String
    var profileImageUrl: String?
    
    
}

extension User {
    static let users: [User] = [
        User(id: "123", userId: "rain", profileImageUrl: "https://cdn.hswstatic.com/gif/google-update.jpg"),
        User(id: "456", userId: "hero")
        
    ]
}
