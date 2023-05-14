//
//  FeedMealModel.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/05/05.
//

import SwiftUI

@MainActor
final class FeedMealModel: ObservableObject {
    @Published var mealList: [Meal] = []
    @Published var userList: [User] = []
    
    func getMealListIn24Hours() {
//        Task {
//            var localUserList: [User] = []
//            let localMealList = try await FirebaseConnector.shared.fetchMealIn24Hours(date: Date())
//            
//            for meal in localMealList {
//                if let user = try? await FirebaseConnector.shared.fetchUser(id: meal.userId) {
//                    localUserList.append(user)
//                }
//            }
//            self.mealList = localMealList
//            self.userList = localUserList
//        }
    }
}
