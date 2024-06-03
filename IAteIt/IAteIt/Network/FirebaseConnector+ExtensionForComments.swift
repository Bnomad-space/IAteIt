//
//  FirebaseConnector+ExtensionForComments.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/04/23.
//

import Firebase
import FirebaseFirestore
import SwiftUI

extension FirebaseConnector {
    static let comments = Firestore.firestore().collection("comments")
    
    // 새로운 comment 생성
    func setNewComment(comment: Comment) async {
        try? await FirebaseConnector.comments.document(comment.id).setData([
            "id": comment.id,
            "userId": comment.userId,
            "mealId": comment.mealId,
            "comment": comment.comment,
            "uploadDate": comment.uploadDate
        ])
    }
    
    // 특정 meal의 모든 comment 데이터 가져오기
    func fetchMealComments(mealId: String) async throws -> [Comment] {
        var commentList: [Comment] = []

        let snapshots = try await FirebaseConnector.comments
            .whereField("mealId", isEqualTo: mealId)
            .getDocuments()
        
        for document in snapshots.documents {
            let comment = try document.data(as: Comment.self)
            commentList.append(comment)
        }
        
        commentList.sort(by: { $0.uploadDate < $1.uploadDate })
        
        return commentList
    }
    
    //특정 comment 삭제
    func deleteComment(commentId: String) {
        Task {
            FirebaseConnector.comments.document(commentId).delete()
        }
    }
    
    // 특정 user의 모든 comment 삭제
    func deleteCommentsByUser(userId: String) async throws {
        let snapshots = try await FirebaseConnector.comments.whereField("userId", isEqualTo: userId).getDocuments()
        
        for document in snapshots.documents {
            try await FirebaseConnector.comments.document(document.documentID).delete()
        }
    }
}
