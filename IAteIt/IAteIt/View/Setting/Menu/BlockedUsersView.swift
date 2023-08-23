//
//  BlockedUsersView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/08/03.
//

import SwiftUI

struct BlockedUsersView: View {
    @EnvironmentObject var loginState: LoginStateModel
    
    var body: some View {
        ScrollView {
            VStack {
                if loginState.blockedUsers.count > 0 {
                    ForEach(loginState.blockedUsers, id:\.self) { blockedUser in
                        BlockedUserView(user: blockedUser)
                            .environmentObject(loginState)
                    }
                } else {
                    VStack(alignment: .center){
                        Text("There are no blocked users.")
                            .font(.body)
                            .foregroundColor(.gray)
                            .padding(.top, 24)
                        Spacer()
                    }
                }
            }
            .padding(.top, .paddingHorizontal)
            .padding(.horizontal, .paddingHorizontal)
            .navigationTitle("Blocked Users")
            .onAppear {
                if let blockedId = loginState.user?.blockedId {
                    loginState.fetchBlockedUsers(blockedIdList: blockedId)
                }
            }
        }
    }
}

struct BlockedUsersView_Previews: PreviewProvider {
    static var previews: some View {
        BlockedUsersView()
    }
}
