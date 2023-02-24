//
//  TempComment.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/24.
//

import Foundation

struct TempComment: Hashable {
    var nickname: String
    var profileImage: String
    var comment: String
    var time: String
}

struct TempCommentData: Hashable {
    var list = [
        TempComment(nickname: "kyeol", profileImage: "Sample_Profile1", comment: "맛있어보이네요", time: "07:45"),
        TempComment(nickname: "willow", profileImage: "Sample_Profile2", comment: "어디인가요?", time: "07:50"),
        TempComment(nickname: "sunshiningsoo", profileImage: "Sample_Profile3", comment: "맥도날드라고 써놨는데", time: "08:15")
    ]
}
