//
//  Block.swift
//  IAteIt
//
//  Created by Beone on 2023/08/04.
//

import Foundation

struct Block: Identifiable, Codable, Hashable {
    let id: String
    var Blocker_id: String
    var Blocked_id: String
}
