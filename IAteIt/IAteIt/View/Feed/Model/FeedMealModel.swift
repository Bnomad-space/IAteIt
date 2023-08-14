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
    
    @Published var myMealHistory: [Meal] = []
    @Published var myMealHistoryCommentList: [String: [Comment]] = [:]
    @Published var myMealHistorySorted: [(key: String, value: [Meal])] = []

    init() {
        self.refreshMealsAndUsers()
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
    
    @MainActor
    func getUserMealHistory(user: User) {
        Task {
            self.myMealHistory = try await FirebaseConnector.shared.fetchUserMealHistory(userId: user.id)
            for meal in self.myMealHistory {
                FirebaseConnector.shared.fetchMealComments(mealId: meal.id!) { comments in
                    self.myMealHistoryCommentList[meal.id!] = comments
                }
            }
            myMealHistorySorted = Dictionary(grouping: myMealHistory) { $0.uploadDate.toDateString() }
                .sorted { $0.value[0].uploadDate > $1.value[0].uploadDate }
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
            await FirebaseConnector.shared.setMealCaption(meal: meal, caption: content)
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
            await FirebaseConnector.shared.setMealLocation(meal: meal, location: content)
            mealList.indices.forEach { index in
                if mealList[index].id == meal.id {
                    DispatchQueue.main.async {
                        self.mealList[index].location = content
                    }
                }
            }
        }
    }
    
    func deletePlate(meal: Meal, plate: Plate) {
        Task {
            guard let mealId = meal.id else { return }
            try await FirebaseConnector.shared.deletePlate(meal: meal, plate: plate)
            try await FirebaseConnector.shared.deletePlateImage(plateId: plate.id)
            DispatchQueue.main.async {
                if let index = self.mealList.firstIndex(where: { $0.id == mealId }) {
                    self.mealList[index].plates.removeAll(where: { $0.id == plate.id })
                }
            }
        }
    }
    
    func deleteMeal(meal: Meal) {
        Task {
            guard let mealId = meal.id else { return }
            try await FirebaseConnector.shared.deleteMeal(meal: meal)
            if let index = self.mealList.firstIndex(where: { $0.id == mealId }) {
                for plate in self.mealList[index].plates {
                    try await FirebaseConnector.shared.deletePlateImage(plateId: plate.id)
                }
                if let commentList = self.commentList[mealId] {
                    for comment in commentList {
                        FirebaseConnector.shared.deleteComment(commentId: comment.id)
                    }
                } else if let commentList = self.myMealHistoryCommentList[mealId] {
                    for comment in commentList {
                        FirebaseConnector.shared.deleteComment(commentId: comment.id)
                    }
                }
            }
            DispatchQueue.main.async {
                self.mealList.removeAll(where: { $0.id == mealId })
                self.commentList[mealId]?.removeAll()
                self.myMealHistoryCommentList[mealId]?.removeAll()
            }
        }
    }
    
    func refreshMealsAndUsers() {
        Task {
            let fetchAllUser = try await FirebaseConnector.shared.fetchAllUsers()
            await MainActor.run {
                self.allUsers = fetchAllUser
                self.getMealListIn24Hours()
            }
        }
    }

    func deleteComment(meal: Meal, comment: Comment) {
        Task {
            guard let mealId = meal.id else { return }
            let commentId = comment.id
            try await FirebaseConnector.shared.deleteComment(commentId: commentId)
            DispatchQueue.main.async {
                self.commentList[mealId]?.removeAll(where: {$0.id == commentId})
            }
        }
    }
}
