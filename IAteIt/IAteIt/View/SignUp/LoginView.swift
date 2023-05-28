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
    @Environment(\.dismiss) var dismiss
    @ObservedObject var loginState: LoginStateModel
    @State var currentNonce: String?
    
    var body: some View {
        VStack {
            Text(loginState.type.setLoginViewTitle())
                .font(.title)
                .fontWeight(.bold)
                .padding([.bottom], 26)
            Text(loginState.type.setLoginViewContent())
                .font(.body)
                .multilineTextAlignment(.center)
                .padding([.bottom], 44)
            
            SignInWithAppleButton(.signIn) { request in
                let nonce = randomNonceString()
                currentNonce = nonce
                request.requestedScopes = [.fullName, .email]
                request.nonce = sha256(nonce)
            } onCompletion: { result in
                loginState.getResultOfAppleLogin(result: result, currentNonce: currentNonce)
            }
            .signInWithAppleButtonStyle(.white)
            .frame(width: 268, height: 50, alignment: .center)
            .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.black, lineWidth: 1)
            )
            .padding([.bottom], 32)
            
            if loginState.type == .createAccount {
                Button(action: {
                    // TODO: 액션 추가
                }, label: {
                    Text("I'll sign in next time.")
                        .font(.body)
                        .foregroundColor(.gray)
                        .underline()
                })
            }
        }
        .onDisappear {
            loginState.isSignUpViewPresent = loginState.isSignUpRequired
            loginState.isShowingDeleteAccountCompleteAlert = loginState.isDeleteAccountCompleteAlertRequired
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
