//
//  FeedMealStore.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/05/05.
//

import SwiftUI
import FirebaseAuth

@MainActor
final class FeedMealStore: ObservableObject {
    @Published var mealList: [Meal] = []
    @Published var allUsers: [User] = []
    @Published var commentList: [String: [Comment]] = [:]
    
    @Published var myMealHistory: [Meal] = []
    @Published var myMealHistoryCommentList: [String: [Comment]] = [:]
    @Published var myMealHistorySorted: [(key: String, value: [Meal])] = []
    
    var isFeedEmpty: Bool {
        mealList.isEmpty ? true : false
    }
    
    init() {
        self.refreshMealsAndUsers()
    }
    
    func getMealListIn24Hours() {
        Task {
            guard let currentUserId = Auth.auth().currentUser?.uid else { return }
            var fetchedMealList = try await FirebaseConnector.shared.fetchMealIn24Hours(date: Date())
            if let currentUser = allUsers.first(where: { $0.id == currentUserId }) {
                if let blockedIdList = currentUser.blockedId {
                    fetchedMealList = fetchedMealList.filter({ !blockedIdList.contains($0.userId) })
                }
            }
            for oneUser in allUsers {
                if let blockedIds = oneUser.blockedId {
                    if blockedIds.contains(currentUserId) {
                        fetchedMealList.removeAll(where: { $0.userId == oneUser.id })
                    }
                }
            }
            
            self.mealList = fetchedMealList
            try await fetchCommentsForFeed(with: self.mealList)
        }
    }
    
    private func fetchCommentsForFeed(with meals: [Meal]) async throws {
        try await withThrowingTaskGroup(of: (mealId: String, comments: [Comment]).self) { group in
            for meal in meals {
                group.addTask {
                    let fetchedComments = try await FirebaseConnector.shared.fetchMealComments(mealId: meal.id!)
                    return (meal.id!, fetchedComments)
                }
            }
            
            for try await item in group {
                self.commentList[item.mealId] = item.comments
            }
        }
    }
    
    func getUserMealHistory(user: User) {
        Task {
            self.myMealHistory = try await FirebaseConnector.shared.fetchUserMealHistory(userId: user.id)
            myMealHistorySorted = Dictionary(grouping: myMealHistory) { $0.uploadDate.toDateString() }
                .sorted { $0.value[0].uploadDate > $1.value[0].uploadDate }
        }
    }
    
    func getMyMealComments(meal: Meal) async throws {
        guard let mealId = meal.id else { return }
        if commentList[mealId] == nil {
            let comments = try await FirebaseConnector.shared.fetchMealComments(mealId: mealId)
            myMealHistoryCommentList[mealId] = comments
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
                } else {
                    let comments = try await FirebaseConnector.shared.fetchMealComments(mealId: mealId)
                    comments.forEach { comment in
                        FirebaseConnector.shared.deleteComment(commentId: comment.id)
                    }
                }
            }
            DispatchQueue.main.async {
                self.mealList.removeAll(where: { $0.id == mealId })
                self.myMealHistory.removeAll(where: { $0.id == mealId})
                self.myMealHistorySorted.removeAll(where: {$0.key == mealId })
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
            FirebaseConnector.shared.deleteComment(commentId: commentId)
            DispatchQueue.main.async {
                self.commentList[mealId]?.removeAll(where: {$0.id == commentId})
            }
        }
    }
}
