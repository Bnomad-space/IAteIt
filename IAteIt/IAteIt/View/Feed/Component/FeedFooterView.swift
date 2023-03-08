//
//  FeedFooterView.swift
//  IAteIt
//
//  Created by Beone on 2023/03/08.
//

import SwiftUI

struct FeedFooterView: View {
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                Text("Caption")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("View all comments")
                    .font(.footnote)
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding([.leading], 16)
    }
}

struct FeedFooterView_Previews: PreviewProvider {
    static var previews: some View {
        FeedFooterView()
    }
}
