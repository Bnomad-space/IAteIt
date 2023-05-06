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
    let firebaseConnector = FirebaseConnector()
    
    func getMealListIn24Hours() {
        Task {
            var localUserList: [User] = []
            let localMealList = try await firebaseConnector.fetchMealIn24Hours(date: Date())
            
            for meal in localMealList {
                if let user = try? await firebaseConnector.fetchUser(id: meal.userId) {
                    localUserList.append(user)
                }
            }
            self.mealList = localMealList
            self.userList = localUserList
        }
    }
}
