//
//  FirebaseConnector.swift
//  IAteIt
//
//  Created by 박성수 on 2023/03/10.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirebaseConnector {
    
    static let users = Firestore.firestore().collection("users")
    /*
     사용 방법: TODO: - 논의된 모델로 Firebase에는 어떻게 저장할 건지 다시 바꿔주어야 함
     FirebaseConnector.users.document("testDocument").setData(["id":"randomId"])
     */
    
    
    
    
}
