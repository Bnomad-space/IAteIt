//
//  SignUpView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var loginState: LoginStateModel
    @ObservedObject var feedMeals: FeedMealModel
    @FocusState private var isFocused: Bool
    @State var username = ""
    @State var isValidFormat: Bool = false
    @State var isUnique: Bool = true
    @State var usernameList: [String] = []
    
    var body: some View {
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
                    isUnique = testUnique(testString: username.lowercased())
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
        .navigationBarHidden(true)
        .overlay {
            VStack {
                Spacer()
                Text("Username must be 4 to 16 alphanumeric characters.\nThe first character must be a letter.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(UIColor.systemGray))
                    .padding(.bottom, 20)
                NavigationLink(destination: SignUpSecondView(loginState: loginState, feedMeals: feedMeals),
                    label: {
                    BottomButtonView(label: "Next")
                })
                .disabled(
                    !isValidFormat || !isUnique
                )
                .simultaneousGesture(TapGesture().onEnded {
                    loginState.username = username.lowercased()
                })
            }
        }
        .task {
            self.usernameList = (try? await FirebaseConnector.shared.fetchAllUsernames()) ?? []
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
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(loginState: LoginStateModel(), feedMeals: FeedMealModel())
    }
}
