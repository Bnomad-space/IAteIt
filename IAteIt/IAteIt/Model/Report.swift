//
//  Report.swift
//  IAteIt
//
//  Created by Beone on 2023/07/05.
//

import Foundation

struct Report: Identifiable, Codable, Hashable {
    let id: String
    var reporterId: String
    var reportedTime: Date
    var mealId: String
    var reason: String
}
