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
    func fetchMealComments(mealId: String, completion: @escaping([Comment]) -> Void) {
        var commentList: [Comment] = []

        FirebaseConnector.comments.whereField("mealId", isEqualTo: mealId).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err.localizedDescription)")
            } else {
                for commentDocument in querySnapshot!.documents {
                    let commentDictionary = commentDocument.data()
                    guard let commentId = commentDictionary["id"] as? String,
                          let userId = commentDictionary["userId"] as? String,
                          let content = commentDictionary["comment"] as? String,
                          let uploadDateTimestamp = commentDictionary["uploadDate"] as? Timestamp
                    else { return }
                    let uploadDate = uploadDateTimestamp.dateValue()

                    let comment = Comment(id: commentId, userId: userId, mealId: mealId, comment: content, uploadDate: uploadDate)
                    commentList.append(comment)
                }
                commentList = commentList.sorted { $0.uploadDate < $1.uploadDate }
                completion(commentList)
            }
        }
    }
    
    //특정 comment 삭제
    func deleteComment(commentId: String) async throws {
        try await FirebaseConnector.comments.document(commentId).delete()
    }
}
