//
//  SignUpView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var loginState: LoginState
    @ObservedObject var signUpState: SignUpState
    @State var username = ""
    @FocusState private var isFocused: Bool
    @State var isValidFormat: Bool = false
    @State var isUnique: Bool = true
    @State var usernameList: [String] = []
    
    var userIdentifier: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Please create your username.")
                    .font(.headline)
                    .padding(.top, 60)
                TextField("username", text: $username)
                    .limitTextLength($username, to: 16)
                    .textCase(.lowercase)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .focused($isFocused)
                    .onAppear() {
                        isFocused = true
                    }
                    .onChange(of: username) { _ in
                        username = username.replacingOccurrences(of: " ", with: "")
                        isValidFormat = testValidUsername(testString: username)
                        isUnique = testUnique(testString: username)
                    }
                    .font(Font.title2.weight(.bold))
                    .multilineTextAlignment(.center)
                    .padding(.top, 40)
                Text("\(username.count) / 16")
                    .font(.caption2)
                    .foregroundColor(.gray)
                if !isUnique {
                    Text("This username is already taken.")
                        .font(.caption2)
                        .foregroundColor(Color(UIColor.systemRed))
                        .padding(.top, 1)
                }
                Spacer()
            }
            .overlay {
                VStack {
                    Spacer()
                    Text("Username must be 4 to 16 alphanumeric characters.\nThe first character must be a letter.")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(UIColor.systemGray))
                        .padding(.bottom, 20)
                    NavigationLink(destination: SignUpSecondView(loginState: loginState, signUpState: signUpState),
                        label: {
                        BottomButtonView(label: "Next")
                    })
                    .disabled(
                        !isValidFormat || !isUnique
                    )
                    .simultaneousGesture(TapGesture().onEnded {
                        signUpState.username = username
                    })
                }
            }
            .onAppear {
                getAllUsernames()
            }
        }
    }
}

extension SignUpView {
    func testValidUsername(testString: String?) -> Bool {
        let regEx = "^[a-zA-Z][a-zA-Z0-9]{3,15}$"
        let usernameTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        return usernameTest.evaluate(with: testString)
    }
    func testUnique(testString: String) -> Bool {
        if usernameList.contains(testString) {
            return false
        } else {
            return true
        }
    }
    func getAllUsernames() {
        FirebaseConnector().fetchAllUsernames { list in
            self.usernameList = list
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(loginState: LoginState(), signUpState: SignUpState())
    }
}
