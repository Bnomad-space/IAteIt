//
//  TempFeedPhotoCard.swift
//  IAteIt
//
//  Created by Beone on 2023/03/07.
//

import Foundation

struct TempFeedPhotoCard: Hashable {
    var nickname: String
    var profileImage: String
    var time: String
    var place: String
}

struct TempFeedPhotoCardData: Hashable {
    var list = [
        TempFeedPhotoCard(nickname: "kyeol", profileImage: "Sample_Profile1", time: "Just before", place: "맥도날드"),
        TempFeedPhotoCard(nickname: "willow", profileImage: "Sample_Profile2", time: "2hours ago", place: "우리집"),
        TempFeedPhotoCard(nickname: "sunshiningsoo", profileImage: "Sample_Profile3", time: "4hours ago", place: "맥도날드")
    ]
}
