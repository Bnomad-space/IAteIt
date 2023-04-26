//
//  LoginUser.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/04/26.
//

import Foundation
import Firebase
import FirebaseAuth

class LoginUser: ObservableObject {
    @Published var appleUid: String = ""
    @Published var user: User?
    @Published var isAppleLoginRequired: Bool = false
    
    init() {
        self.checkLoginUser()
    }
    
    func checkLoginUser() {
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            guard let userUid = currentUser?.uid else { return }
            FirebaseConnector().checkExistingUser(userUid: userUid) { isExist in
                if isExist {
                    FirebaseConnector().fetchUser(id: userUid) { user in
                        self.user = user
                    }
                    self.isAppleLoginRequired = false
                } else {
                    self.isAppleLoginRequired = true
                }
            }
        } else {
            self.isAppleLoginRequired = true
        }
    }
}
