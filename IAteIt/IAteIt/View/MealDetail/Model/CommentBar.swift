//
//  CommentBar.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/04/14.
//

import SwiftUI

class CommentBar: ObservableObject {
    enum types {
        case comment
        case caption
        case location
        
        func placeholder() -> String {
            switch self {
            case .comment:
                return "Add a comment..."
            case .caption:
                return "Add a caption..."
            case .location:
                return "Add location..."
            }
        }
    }
    
    @Published var type = types.comment
    @Published var input = ""
}
