//
//  FeedMealModel.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/05/05.
//

import SwiftUI
import FirebaseAuth

final class FeedMealModel: ObservableObject {
    @Published var mealList: [Meal] = []
    @Published var userList: [User] = []
    
    @MainActor
    func getMealListIn24Hours() {
        Task {
            var localUserList: [User] = []
            let localMealList = try await FirebaseConnector.shared.fetchMealIn24Hours(date: Date())
            var tempList: [Meal] = []
            for meal in localMealList {
                FirebaseConnector.shared.fetchMealComments(mealId: meal.id!) { comments in
                    var temp = meal
                    temp.comments = comments
                    tempList.append(temp)
                }
            }
            
            for meal in localMealList {
                if let user = try? await FirebaseConnector.shared.fetchUser(id: meal.userId) {
                    localUserList.append(user)
                }
            }
            self.mealList = tempList
            self.userList = localUserList
        }
    }
    
    func commentUpload(meal: Meal, comment: String) {
        Task {
            if let current = Auth.auth().currentUser {
                let uploadComment = Comment(id: UUID().uuidString, userId: current.uid, mealId: meal.id!, comment: comment, uploadDate: Date())
                await FirebaseConnector.shared.setNewComment(comment: uploadComment)
            }
        }
    }
}
