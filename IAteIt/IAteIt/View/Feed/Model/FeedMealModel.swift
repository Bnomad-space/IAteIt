//
//  FeedMealModel.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/05/05.
//

import SwiftUI
import FirebaseAuth

final class FeedMealModel: ObservableObject {
    @Published var mealList: [Meal] = [] {
        didSet {
            self.mealList.sorted { $0.uploadDate > $1.uploadDate }
        }
    }
    @Published var allUsers: [User] = []
    
    init() {
        Task {
            let fetchAllUser = try await FirebaseConnector.shared.fetchAllUsers()
            await MainActor.run {
                self.allUsers = fetchAllUser
                self.getMealListIn24Hours()
            }
        }
    }
    
    @MainActor
    func getMealListIn24Hours() {
        Task {
            var localMealList = try await FirebaseConnector.shared.fetchMealIn24Hours(date: Date())
            var tempList: [Meal] = []
            for meal in localMealList {
                FirebaseConnector.shared.fetchMealComments(mealId: meal.id!) { comments in
                    var temp = meal
                    temp.comments = comments
                    tempList.append(temp)
                    self.mealList = tempList.sorted { $0.uploadDate > $1.uploadDate }
                }
            }
        }
    }
    
    func commentUpload(meal: Meal, comment: String) {
        Task {
            if let current = Auth.auth().currentUser {
                let uploadComment = Comment(id: UUID().uuidString, userId: current.uid, mealId: meal.id!, comment: comment, uploadDate: Date())
                await FirebaseConnector.shared.setNewComment(comment: uploadComment)
                mealList.indices.forEach { index in
                    if mealList[index].id == meal.id {
                        DispatchQueue.main.async {
                            self.mealList[index].comments?.append(uploadComment)
                        }
                    }
                }
            }
        }
    }
    
    func saveCaption(meal: Meal, content: String) {
        Task {
            await FirebaseConnector.shared.setMealCaption(mealId: meal.id!, caption: content)
            mealList.indices.forEach { index in
                if mealList[index].id == meal.id {
                    DispatchQueue.main.async {
                        self.mealList[index].caption = content
                    }
                }
            }
        }
    }
    
    func saveLocation(meal: Meal, content: String) {
        Task {
            await FirebaseConnector.shared.setMealLocation(mealId: meal.id!, location: content)
            mealList.indices.forEach { index in
                if mealList[index].id == meal.id {
                    DispatchQueue.main.async {
                        self.mealList[index].location = content
                    }
                }
            }
        }
    }
}
