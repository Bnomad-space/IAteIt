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
    @Published var isSignUpRequired: Bool = false
    @Published var isDeleteAccountCompleteAlertRequired = false
    @Published var isShowingDeleteAccountCompleteAlert = false
    @Published var type = types.createAccount
    
    enum types {
        case createAccount
        case deleteAccount
        
        func setLoginViewTitle() -> String {
            switch self {
            case .createAccount:
                return "Sign in required!"
            case .deleteAccount:
                return "Delete your account"
            }
        }
        
        func setLoginViewContent() -> String {
            switch self {
            case .createAccount:
                return "Please sign in\nto share what you eat in a day."
            case .deleteAccount:
                return "Confirm account deletion by sign in again."
            }
        }
    }
    
    init() {
        self.checkLoginUser()
    }
    
    func checkLoginUser() {
        Task {
            let currentUser = Auth.auth().currentUser
            if currentUser != nil {
                guard let userUid = currentUser?.uid else { return }
                let isExist = try await FirebaseConnector.shared.checkExistingUser(userUid: userUid)
                if isExist {
                    let fetchedUser = try await FirebaseConnector.shared.fetchUser(id: userUid)
                    await MainActor.run {
                        self.user = fetchedUser
                        self.isAppleLoginRequired = false
                    }
                } else {
                    await MainActor.run {
                        self.type = .createAccount
                        self.isAppleLoginRequired = true
                    }
                }
            } else {
                await MainActor.run {
                    self.type = .createAccount
                    self.isAppleLoginRequired = true
                }
            }
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
                if self.type == .createAccount {
                    signInComplete(credential: credential)
                } else if self.type == .deleteAccount {
                    deleteAccount(credential: credential)
                }
                print("\(String(describing: Auth.auth().currentUser?.uid))")
                
            default:
                break
            }
            
        case .failure(let error):
          print("Authorisation failed: \(error.localizedDescription)")
        }
    }
    
    func signInToFirebase(credential: AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        let result = AuthDataResultModel(uid: authDataResult.user.uid, email: authDataResult.user.email ?? "-")
        return result
    }
    
    func signInComplete(credential: AuthCredential) {
        Task {
            do {
                let returnedUserData = try await signInToFirebase(credential: credential)
                let userUid = returnedUserData.uid
                print("애플 로그인 결과: \(userUid), \(returnedUserData.email)")
                
                let isExist = try await FirebaseConnector.shared.checkExistingUser(userUid: userUid)
                if isExist {
                    let fetchedUser = try await FirebaseConnector.shared.fetchUser(id: userUid)
                    await MainActor.run {
                        self.user = fetchedUser
                        self.isAppleLoginRequired = false
                    }
                } else {
                    await MainActor.run {
                        self.appleUid = userUid
                        self.isSignUpRequired = true
                    }
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func deleteAccount(credential: AuthCredential) {
        Task {
            do {
                let returnedUserData = try await signInToFirebase(credential: credential)
                let userId = returnedUserData.uid
                print("애플 로그인 결과: \(userId), \(returnedUserData.email)")
                try await FirebaseConnector.shared.deleteUserFromAuth()
                if let imageUrl = user?.profileImageUrl {
                    try await FirebaseConnector.shared.deleteProfileImage(userId: userId)
                }
                try await FirebaseConnector.shared.deleteUser(userId: userId)
                try await FirebaseConnector.shared.deleteCommentsByUser(userId: userId)
                try await FirebaseConnector.shared.deleteMealsByUser(userId: userId)
                await MainActor.run {
                    self.user = nil
                    self.isAppleLoginRequired = false
                    self.isDeleteAccountCompleteAlertRequired = true
                }
            } catch {
                print("error deleting user: \(error)")
            }
        }
    }
}
