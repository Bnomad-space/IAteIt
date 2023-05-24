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
    @Published var commentList: [String: [Comment]] = [:]
    
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
            self.mealList = try await FirebaseConnector.shared.fetchMealIn24Hours(date: Date())
            for meal in self.mealList {
                FirebaseConnector.shared.fetchMealComments(mealId: meal.id!) { comments in
                    self.commentList[meal.id!] = comments
                }
            }
        }
    }
    
    func commentUpload(meal: Meal, comment: String) {
        Task {
            if let current = Auth.auth().currentUser {
                let uploadComment = Comment(id: UUID().uuidString, userId: current.uid, mealId: meal.id!, comment: comment, uploadDate: Date())
                await FirebaseConnector.shared.setNewComment(comment: uploadComment)
                DispatchQueue.main.async {
                    self.commentList[meal.id!]!.append(uploadComment)
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
