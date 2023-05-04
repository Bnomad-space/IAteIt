//
//  LoginState.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/04/26.
//

import AuthenticationServices
import CryptoKit
import Foundation
import Firebase
import FirebaseAuth

class LoginStateModel: ObservableObject {
    @Published var appleUid: String = ""
    @Published var username: String = ""
    @Published var user: User?
    @Published var isAppleLoginRequired: Bool = false
    @Published var isSignUpViewPresent: Bool = false
    @Published var isSignUpRequired: Bool = false
    
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
    
    func getResultOfAppleLogin(result: Result<ASAuthorization, Error>, currentNonce: String?) {
        switch result {
        case .success(let authResults):
            print("Authorisation successful \(authResults)")
          
            switch authResults.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                guard let nonce = currentNonce else {
                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
                }
                guard let appleIDToken = appleIDCredential.identityToken else {
                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
                }
                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                    print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                    return
                }
                let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
                Auth.auth().signIn(with: credential) { (authResult, error) in
                    if error != nil {
                        // Error. If error.code == .MissingOrInvalidNonce, make sure
                        // you're sending the SHA256-hashed nonce as a hex string with
                        // your request to Apple.
                        print(error?.localizedDescription as Any)
                        return
                    }
                    if let authUser = authResult?.user {
                        print("애플 로그인 결과:", authUser.uid, authUser.email ?? "-")
                        FirebaseConnector().checkExistingUser(userUid: authUser.uid) { isExist in
                            if isExist {
                                FirebaseConnector().fetchUser(id: authUser.uid) { fetchedUser in
                                    self.user = fetchedUser
                                    self.isAppleLoginRequired = false
                                }
                            } else {
                                self.appleUid = authUser.uid
                                self.isAppleLoginRequired = false
                                self.isSignUpRequired = true
                            }
                        }
                    }
                }
                print("\(String(describing: Auth.auth().currentUser?.uid))")
                
            default:
                break
            }
            
        case .failure(let error):
          print("Authorisation failed: \(error.localizedDescription)")
        }
    }
}
