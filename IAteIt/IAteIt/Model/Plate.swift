//
//  Plate.swift
//  IAteIt
//
//  Created by 박성수 on 2023/03/06.
//

import Foundation

struct Plate: Identifiable, Codable, Hashable {
    let id: String
    let mealId: String
    var imageUrl: String
    let uploadDate: Date
    
}

extension Plate {
    static let plates: [Plate] = [
        Plate(id: "plate1", mealId: "meal1", imageUrl: "https://cdn.shopify.com/app-store/listing_images/a78e004f44cded1b6998e7a6e081a230/promotional_image/CPKYl-_NivsCEAE=.png?height=720&width=1280", uploadDate: Date()),
        Plate(id: "plate2", mealId: "meal1", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSK5q0FP74VV9wbfwP378_7kj7iDomHuKrxkXsxDdUT28V9dlVMNUe-EMzaLwaFhneeuZI&usqp=CAU", uploadDate: Date()),
        Plate(id: "plate3", mealId: "meal2", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSK5q0FP74VV9wbfwP378_7kj7iDomHuKrxkXsxDdUT28V9dlVMNUe-EMzaLwaFhneeuZI&usqp=CAU", uploadDate: Date()),
        Plate(id: "plate4", mealId: "meal3", imageUrl: "https://images.unsplash.com/photo-1525351326368-efbb5cb6814d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80", uploadDate: Date()),
        Plate(id: "plate5", mealId: "meal3", imageUrl: "https://eatbook.sg/wp-content/uploads/2018/11/Marina-Square-Food-Beyond-Pancakes-min.png", uploadDate: Date()),
        Plate(id: "plate5", mealId: "meal4", imageUrl: "https://cdn.shopify.com/app-store/listing_images/a78e004f44cded1b6998e7a6e081a230/promotional_image/CPKYl-_NivsCEAE=.png?height=720&width=1280", uploadDate: Date())
    ]
    
}
