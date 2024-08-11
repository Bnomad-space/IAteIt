//
//  FirebaseString.swift
//  IAteIt
//
//  Created by 박성수 on 8/11/24.
//

import Foundation

struct FirebaseString {
    #if DEBUG
    static let meals = "meals"
    static let mealByDay = "mealsByDayDebug"
    #else
    static let meals = "meals2"
    static let mealByDay = "mealsByDay"
    #endif
    
}
