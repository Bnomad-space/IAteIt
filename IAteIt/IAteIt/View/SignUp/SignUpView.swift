//
//  SignUpView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI

struct SignUpView: View {
    @State private var username = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            Text("Please create your username.")
                .font(.headline)
                .padding(.top, 60)
            TextField("username", text: $username)
                .limitTextLength($username, to: 16)
                .textInputAutocapitalization(.never)
                .focused($isFocused)
                .onAppear() {
                    isFocused = true
                }
                .onChange(of: username) { _ in
                    username = username.replacingOccurrences(of: " ", with: "")
                }
                .font(Font.title2.weight(.bold))
                .multilineTextAlignment(.center)
                .padding(.top, 40)
            Text("\(username.count) / 16")
                .font(.caption2)
                .foregroundColor(.gray)
            Spacer()
        }
        .overlay {
            VStack {
                Spacer()
                Text("Username must be between 3 and 16 characters.")
                    .font(.subheadline)
                    .foregroundColor(Color(UIColor.systemGray))
                    .padding(.bottom, 20)
                NavigationLink(destination: SignUpSecondView()
                    , label: {
                    BottomButtonView(label: "Next")
                })
                .disabled(username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || username.count < 3)
                .simultaneousGesture(TapGesture().onEnded {
                    //TODO: username 저장
                })
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
