//
//  TempFeedPhotoCard.swift
//  IAteIt
//
//  Created by Beone on 2023/03/07.
//

import Foundation

struct TempFeedHeader: Hashable {
    var nickname: String
    var profileImage: String
    var time: String
    var place: String
}

struct TempFeedPhotoCardData: Hashable {
    var list = [
        TempFeedHeader(nickname: "kyeol", profileImage: "Sample_Profile1", time: "Just before", place: "맥도날드"),
        TempFeedHeader(nickname: "willow", profileImage: "Sample_Profile2", time: "2hours ago", place: "우리집"),
        TempFeedHeader(nickname: "sunshiningsoo", profileImage: "Sample_Profile3", time: "4hours ago", place: "맥도날드")
    ]
}
