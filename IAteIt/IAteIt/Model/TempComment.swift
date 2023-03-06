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
        TempComment(nickname: "sunshiningsoo", profileImage: "Sample_Profile3", comment: "맥도날드라고 써놨는데.... 긴 코멘트를 작성해서 두줄이 넘어가면 어떻게 나온느지 보기 위해 길게 작성해보는 중이다. 어떻게 나올지 모르겠다. 자동으로 줄바꿈이 되었으면 좋겠다^^", time: "08:15")
    ]
}
