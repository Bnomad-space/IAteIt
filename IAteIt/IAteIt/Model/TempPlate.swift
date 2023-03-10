//
//  TempPlate.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/24.
//

import Foundation

struct TempPlate: Hashable {
    var image: String
    var location: String
    var time: String
}

struct TempPlateData: Hashable {
    var list = [
        TempPlate(image: "Sample_McMorning", location: "맥도날드", time: "07:20"),
        TempPlate(image: "Sample_Coffee", location: "맥도날드", time: "07:24"),
        TempPlate(image: "Sample_Hashbrown", location: "계속맥도날드", time: "07:27")
    ]
}
