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
    
    func fetchBlocksByBlockerId(blockerId: String) async throws -> [String] {
        var blocks: [String] = []
        
        do {
            let querySnapshot = try await FirebaseConnector.blocks.whereField("Blocker_id", isEqualTo: blockerId).getDocuments()
            
            for document in querySnapshot.documents {
                let blockData = document.data()
                if let blockedId = blockData["Blocked_id"] as? String {
                    blocks.append(blockedId)
                }
            }
            return blocks
        } catch {
            throw error
        }
    }
    
    func fetchAllBlocks() async throws -> [Block] {
        var blocks: [Block] = []
        
        do {
            let querySnapshot = try await FirebaseConnector.blocks.getDocuments()
            
            for document in querySnapshot.documents {
                let blockData = try document.data(as: Block.self)
                blocks.append(blockData)
            }
            
            return blocks
        } catch {
            throw error
        }
    }
    
//user 구조에 block 삽입
    func addBlockedId(user: User, BlockedId: String) async throws {
        try await FirebaseConnector.users.document(user.id)
            .updateData(["blockedId": FieldValue.arrayUnion([BlockedId])])
    }
    
}
