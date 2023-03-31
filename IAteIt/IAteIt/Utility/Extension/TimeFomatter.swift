//
//  TimeFomatter.swift
//  IAteIt
//
//  Created by 유재훈 on 2023/03/31.
//

import Foundation

extension Date {
    
    func toTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date_string = formatter.string(from: self)
        return date_string
    }
}

