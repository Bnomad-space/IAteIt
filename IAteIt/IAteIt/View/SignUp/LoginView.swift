//
//  LoginView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/03/26.
//

import AuthenticationServices
import CryptoKit
import FirebaseAuth
import SwiftUI

struct LoginView: View {
    @ObservedObject var loginState: LoginStateModel
    @State var currentNonce: String?
    @State var isSignUpRequired: Bool = false
    
    var body: some View {
        VStack {
            Text("Sign in required!")
                .font(.title)
                .fontWeight(.bold)
                .padding([.bottom], 26)
            Text("Please sign in\nto share what you eat in a day.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding([.bottom], 44)
            
            SignInWithAppleButton(.signIn) { request in
                let nonce = randomNonceString()
                currentNonce = nonce
                request.requestedScopes = [.fullName, .email]
                request.nonce = sha256(nonce)
                
            } onCompletion: { result in
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
                            if let user = authResult?.user {
                                print("애플 로그인 결과:", user.uid, user.email ?? "-")
                                FirebaseConnector().checkExistingUser(userUid: user.uid) { isExist in
                                    if isExist {
                                        FirebaseConnector().fetchUser(id: user.uid) { user in
                                            loginState.user = user
                                            loginState.isAppleLoginRequired = false
                                        }
                                    } else {
                                        loginState.appleUid = user.uid
                                        loginState.isAppleLoginRequired = false
                                        isSignUpRequired = true
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
            .signInWithAppleButtonStyle(.white)
            .frame(width: 268, height: 50, alignment: .center)
            .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.black, lineWidth: 1)
            )
            .padding([.bottom], 32)
            
            Button(action: {
                // TODO: 액션 추가
            }, label: {
                Text("I'll sign in next time.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .underline()
            })
        }
        .onDisappear {
            loginState.isSignUpViewPresent = isSignUpRequired
        }
    }
}

extension LoginView {
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    
    // from https://firebase.google.com/docs/auth/ios/apple
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      var randomBytes = [UInt8](repeating: 0, count: length)
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }

      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

      let nonce = randomBytes.map { byte in
        // Pick a random character from the set, wrapping around if needed.
        charset[Int(byte) % charset.count]
      }

      return String(nonce)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginState: LoginStateModel())
    }
}
