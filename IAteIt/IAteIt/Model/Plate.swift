//
//  Plate.swift
//  IAteIt
//
//  Created by 박성수 on 2023/03/06.
//

import Foundation

struct Plate: Identifiable, Codable {
    let id: String
    let mealId: String
    var imageUrl: String
    let uploadTimestamp: Date
    
}

extension Plate {
    static let plates: [Plate] = [
        Plate(id: "plate1", mealId: "meal1", imageUrl: "https://cdn.shopify.com/app-store/listing_images/a78e004f44cded1b6998e7a6e081a230/promotional_image/CPKYl-_NivsCEAE=.png?height=720&width=1280", uploadTimestamp: Date()),
        Plate(id: "plate2", mealId: "meal1", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSK5q0FP74VV9wbfwP378_7kj7iDomHuKrxkXsxDdUT28V9dlVMNUe-EMzaLwaFhneeuZI&usqp=CAU", uploadTimestamp: Date()),
        Plate(id: "plate3", mealId: "meal2", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSK5q0FP74VV9wbfwP378_7kj7iDomHuKrxkXsxDdUT28V9dlVMNUe-EMzaLwaFhneeuZI&usqp=CAU", uploadTimestamp: Date())
    ]
    
}
