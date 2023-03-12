//
//  User.swift
//  IAteIt
//
//  Created by 박성수 on 2023/03/06.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    var userName: String
    var profileImageUrl: String?
    
    
}

extension User {
    static let users: [User] = [
        User(id: "123", userName: "rain", profileImageUrl: "https://cdn.hswstatic.com/gif/google-update.jpg"),
        User(id: "456", userName: "hero")
        
    ]
}
