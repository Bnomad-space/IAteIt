//
//  LoginView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/03/26.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
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
                  request.requestedScopes = [.fullName, .email]
                } onCompletion: { result in
                  switch result {
                    case .success(let authResults):
                      print("Authorisation successful \(authResults)")
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
            
            Text("I'll sign in next time.")
                .font(.body)
                .foregroundColor(.gray)
                .underline()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
