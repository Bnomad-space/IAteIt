//
//  BlockedUsersView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/08/03.
//

import SwiftUI

struct BlockedUsersView: View {
    
    
    var body: some View {
        VStack(alignment: .center){
            Text("There are no blocked users.")
                .font(.body)
                .foregroundColor(.gray)
        }
        .navigationTitle("Blocked Users")
        
        
    }
}

struct BlockedUsersView_Previews: PreviewProvider {
    static var previews: some View {
        BlockedUsersView()
    }
}
