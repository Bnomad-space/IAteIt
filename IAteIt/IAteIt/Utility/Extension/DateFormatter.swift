//
//  DateFormatter.swift
//  IAteIt
//
//  Created by Youngwoong Choi on 2023/03/12.
//

import Foundation

extension Date {
    
    /// dateFormat = "yyyy-MM-dd" ex) 2021-10-18
    func toDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        let date_string = formatter.string(from: self)
        return date_string
    }
    
    func toDateString2() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date_string = formatter.string(from: self)
        return date_string
    }
    
    /// dateFormat = "yyyy-MM-dd HH:mm:ss" ex) 2021-10-18 12:00:00
    func toDateTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date_string = formatter.string(from: self)
        return date_string
    }
    
    func toTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date_string = formatter.string(from: self)
        return date_string
    }
    
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
