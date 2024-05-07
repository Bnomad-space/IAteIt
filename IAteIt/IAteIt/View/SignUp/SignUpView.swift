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
    @StateObject var usernameValidModel = UsernameValidModel()
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            Text("Please create your username.")
                .font(.headline)
                .padding(.top, 60)
            TextField("username", text: $usernameValidModel.text)
                .limitTextLength($usernameValidModel.text, to: 16)
                .textCase(.lowercase)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .focused($isFocused)
                .onAppear() {
                    isFocused = true
                }
                .onChange(of: usernameValidModel.text) { _ in
                    usernameValidModel.updateConstraints()
                }
                .font(Font.title2.weight(.bold))
                .multilineTextAlignment(.center)
                .padding(.top, 40)
            Text("\(usernameValidModel.textCount()) / 16")
                .font(.caption2)
                .foregroundColor(usernameValidModel.textValidColor())
            if !usernameValidModel.ifIsUnique() {
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
                    usernameValidModel.buttonDisable()
                )
                .simultaneousGesture(TapGesture().onEnded {
                    loginState.username = usernameValidModel.text.lowercased()
                })
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(loginState: LoginStateModel(), feedMeals: FeedMealModel())
    }
}
