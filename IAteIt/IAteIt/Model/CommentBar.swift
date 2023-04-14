//
//  CommentBar.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/04/14.
//

import SwiftUI

enum CommentBarType {
    case comment
    case caption
    case location
    
    func commentBarPlaceholder() -> String {
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

class CommentBar: ObservableObject {
    @Published var type = CommentBarType.comment
    @Published var input = ""
}
