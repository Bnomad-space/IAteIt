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
    let plate: [MockPlate]
}

struct MockPlate {
    let mealId: String
    var caption: String?
    var imageUrl: String
    let uploadTimestamp: Date
}

struct DailyMealCellView: View {
    let paddingLR: CGFloat = 16
    
    let meals: [Meal] = [
        Meal(id: "1", user: "hero", date: Date.now, plate: [MockPlate(mealId: "1", imageUrl: "https://cdn.hswstatic.com/gif/google-update.jpg", uploadTimestamp: Date.now)]),
        Meal(id: "2", user: "hero", date: Date.now, plate: [MockPlate(mealId: "2", imageUrl: "https://cdn.hswstatic.com/gif/google-update.jpg", uploadTimestamp: Date.now)]),
        Meal(id: "3", user: "joij", date: Date.now, plate: [MockPlate(mealId: "3", imageUrl: "https://cdn.hswstatic.com/gif/google-update.jpg", uploadTimestamp: Date.distantPast)]),
        Meal(id: "3", user: "joij", date: Date.now, plate: [MockPlate(mealId: "3", imageUrl: "https://cdn.hswstatic.com/gif/google-update.jpg", uploadTimestamp: Date.distantPast)]),
        Meal(id: "3", user: "joij", date: Date.now, plate: [MockPlate(mealId: "3", imageUrl: "https://cdn.hswstatic.com/gif/google-update.jpg", uploadTimestamp: Date.distantPast)])
    ]
    
        
    var body: some View {
        VStack(alignment: .leading) {
            
//            Meal / Plate 데이터에서 날짜값 가져와서 String으로 변환 예정.
//            오늘 날짜인지 판별 후 오늘 날짜라면 날짜형식이 아닌 Today 로 변환 필요.
//            Text(meals[0].date.toDateString())
            Text("Today")
                .font(.footnote)
                .fontWeight(.semibold)
            
//            동일 날짜의 Meal의 갯수에 따라 row 안의 rectangle 배열 디자인 변화
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
