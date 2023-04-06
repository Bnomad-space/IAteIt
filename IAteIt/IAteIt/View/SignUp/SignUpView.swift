//
//  SignUpView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI

struct SignUpView: View {
    @State private var username = ""
    
    var body: some View {
        VStack {
            Text("Please create your username.")
                .font(.headline)
                .padding(.top, 60)
            TextField("username", text: $username)
                .limitTextLength($username, to: 16)
                .textInputAutocapitalization(.never)
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
                Button(action: {
                    // TODO: username 저장, 다음 뷰로 넘기기
                }, label: {
                    BottomButtonView(label: "Next")
                })
                .disabled(username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
