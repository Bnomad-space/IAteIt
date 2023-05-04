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
        Plate(id: "plate1", mealId: "meal1", imageUrl: "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80", uploadDate: Date()-60),
        Plate(id: "plate2", mealId: "meal1", imageUrl: "https://images.unsplash.com/photo-1572449043416-55f4685c9bb7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80", uploadDate: Date()-30),
        Plate(id: "plate3", mealId: "meal2", imageUrl: "https://images.unsplash.com/photo-1525351484163-7529414344d8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80", uploadDate: Date()-60*60),
        Plate(id: "plate4", mealId: "meal3", imageUrl: "https://images.unsplash.com/photo-1605851868183-7a4de52117fa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80", uploadDate: Date()-60*60*4),
        Plate(id: "plate5", mealId: "meal3", imageUrl: "https://eatbook.sg/wp-content/uploads/2018/11/Marina-Square-Food-Beyond-Pancakes-min.png", uploadDate: Date()-60*60*4+30*60),
        Plate(id: "plate5", mealId: "meal4", imageUrl: "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80", uploadDate: Date()-60*60*12)
    ]
    

    static let plate1 = Plate(id: "plate1", mealId: "meal1", imageUrl: "Sample_McMorning", uploadDate: Date())
    static let plate2 = Plate(id: "plate2", mealId: "meal1", imageUrl: "Sample_Hashbrown", uploadDate: Date())

    static let plate3 = Plate(id: "plate3", mealId: "meal2", imageUrl: "Sample_Hashbrown", uploadDate: Date())
    static let plate4 = Plate(id: "plate4", mealId: "meal2", imageUrl: "Sample_McMorning", uploadDate: Date())

    static let plate5 = Plate(id: "plate5", mealId: "meal3", imageUrl: "Sample_McMorning", uploadDate: Date())
    static let plate6 = Plate(id: "plate6", mealId: "meal3", imageUrl: "Sample_McMorning", uploadDate: Date())

    static let plate7 = Plate(id: "plate7", mealId: "meal3", imageUrl: "Sample_Coffee", uploadDate: Date())
    static let plate8 = Plate(id: "plate8", mealId: "meal3", imageUrl: "Sample_Hashbrown", uploadDate: Date())
    static let plate9 = Plate(id: "plate9", mealId: "meal3", imageUrl: "Sample_Hashbrown", uploadDate: Date())
    static let plate10 = Plate(id: "plate10", mealId: "meal3", imageUrl: "https://example.com/plate10.jpg", uploadDate: Date())
    static let plate11 = Plate(id: "plate11", mealId: "meal3", imageUrl: "https://example.com/plate11.jpg", uploadDate: Date())
    static let plate12 = Plate(id: "plate12", mealId: "meal3", imageUrl: "https://example.com/plate12.jpg", uploadDate: Date())

}
