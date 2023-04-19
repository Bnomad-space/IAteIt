//
//  FirebaseTestView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/04/18.
//

import SwiftUI

struct FirebaseTestView: View {
    
    var body: some View {
        VStack {
            Button(action: {
                let user = User(id: "testUser1Id", nickname: "testUser1Nickname")
                FirebaseConnector().setNewUser(user: user)
            }, label: {
                Text("Sign up")
            })
            Button(action: {
                let user = User(id: "testUser1Id", nickname: "testUser1NicknameEdited", profileImageUrl: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80")
                FirebaseConnector().updateUser(user: user)
            }, label: {
                Text("Edit User")
            })
            Button(action: {
                FirebaseConnector().fetchUser(id: "testUser1Id") { user in
                    print(user.id)
                    print(user.nickname)
                    if let profileImage = user.profileImageUrl {
                        print(profileImage)
                    }
                }
            }, label: {
                Text("Fetch user")
            })
        }
    }
}
