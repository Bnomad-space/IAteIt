//
//  DailyMealCellView.swift
//  IAteIt
//
//  Created by Youngwoong Choi on 2023/03/12.
//

import SwiftUI

struct Meal: Identifiable {
    let id: String
    let user: String
    let date: Date
    var location: String?
    let plate: [Plate]
}

struct Plate {
    let mealId: String
    var caption: String?
    var imageUrl: String
    let uploadTimestamp: Date
}

struct DailyMealCellView: View {
    let paddingLR: CGFloat = 16
    
    let meals: [Meal] = [
        Meal(id: "1", user: "hero", date: Date.now, plate: [Plate(mealId: "1", imageUrl: "https://cdn.hswstatic.com/gif/google-update.jpg", uploadTimestamp: Date.now)]),
        Meal(id: "2", user: "hero", date: Date.now, plate: [Plate(mealId: "2", imageUrl: "https://cdn.hswstatic.com/gif/google-update.jpg", uploadTimestamp: Date.now)]),
        Meal(id: "3", user: "joij", date: Date.now, plate: [Plate(mealId: "3", imageUrl: "https://cdn.hswstatic.com/gif/google-update.jpg", uploadTimestamp: Date.distantPast)]),
        Meal(id: "3", user: "joij", date: Date.now, plate: [Plate(mealId: "3", imageUrl: "https://cdn.hswstatic.com/gif/google-update.jpg", uploadTimestamp: Date.distantPast)]),
        Meal(id: "3", user: "joij", date: Date.now, plate: [Plate(mealId: "3", imageUrl: "https://cdn.hswstatic.com/gif/google-update.jpg", uploadTimestamp: Date.distantPast)])
    ]
    
        
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(meals[0].date.toDateString())
                .font(.footnote)
                .fontWeight(.semibold)
            
            if meals.count >= 4 {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top) {
                        ForEach(meals) { meal in
                            RoundedRectangle(cornerRadius: 15)
                                .frame(minWidth: 100, idealHeight: 128)
                        }
                    }
                }.frame(height: 128, alignment: .bottomTrailing)
            } else {
                HStack(alignment: .top) {
                    ForEach(meals) { meal in
                        RoundedRectangle(cornerRadius: 15).frame(height: 128, alignment: .top)
                    }
                }
            }
        }.padding([.leading, .trailing], paddingLR)
    }
}

struct DailyMealCellView_Previews: PreviewProvider {
    static var previews: some View {
        DailyMealCellView()
    }
}
