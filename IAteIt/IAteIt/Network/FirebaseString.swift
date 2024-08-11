//
//  FirebaseString.swift
//  IAteIt
//
//  Created by 박성수 on 8/11/24.
//

import Foundation

struct FirebaseString {
    #if DEBUG
    static let mealByDay = "mealsByDayDebug"
    #else
    static let mealByDay = "mealsByDay"
    #endif
    
}
