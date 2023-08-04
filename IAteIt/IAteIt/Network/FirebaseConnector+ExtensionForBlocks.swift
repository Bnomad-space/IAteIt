//
//  FirebaseConnector+ExtensionForBlocks.swift
//  IAteIt
//
//  Created by Beone on 2023/08/04.
//

import Firebase
import FirebaseFirestore
import SwiftUI

extension FirebaseConnector {
    static let blocks = Firestore.firestore().collection("blocks")
    
    func setBlock(Blocker_id: String, Blocked_id: String) {
        let block = Block(
            id: UUID().uuidString,
            Blocker_id: Blocker_id,
            Blocked_id: Blocked_id
        )
        
        do {
            let documentData = try Firestore.Encoder().encode(block)
            FirebaseConnector.blocks.document(block.id).setData(documentData) { error in
                if let error = error {
                    print("Failed to set block: \(error.localizedDescription)")
                } else {
                    print("block sent successfully!")
                }
            }
        } catch {
            print("Error encoding block: \(error.localizedDescription)")
        }
    }

//    func fetchBlocksByBlockerId(blockerId: String, completion: @escaping ([Block]?, Error?) -> Void) {
//        FirebaseConnector.blocks
//            .whereField("blocker_id", isEqualTo: blockerId)
//            .getDocuments { snapshot, error in
//                if let error = error {
//                    completion(nil, error)
//                    return
//                }
//
//                var blocks: [Block] = []
//                for document in snapshot?.documents ?? [] {
//                    do {
//                        let blockData = try document.data(as: Block.self)
//                        blocks.append(blockData)
//                    } catch {
//                        completion(nil, error)
//                        return
//                    }
//                }
//
//                completion(blocks, nil)
//            }
//    }
    
    func fetchBlocksByBlockerId(blockerId: String) async throws -> [String] {
        var blocks: [String] = []
        
        FirebaseConnector.blocks.whereField("blocker_id", isEqualTo: blockerId)
            .getDocuments() { (snapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in snapshot?.documents ?? [] {
                        let blockData = document.data()
                        guard let blocked_id = blockData["blocked_id"] as? String else {return}
                        blocks.append(blocked_id)
                    }
                }
            }
        return blocks
    }
    
}
