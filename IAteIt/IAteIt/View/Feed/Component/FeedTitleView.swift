//
//  FeedTitleView.swift
//  IAteIt
//
//  Created by Beone on 2023/03/08.
//

import SwiftUI

struct FeedTitleView: View {
    var body: some View {
        HStack(alignment: .center) {
            Text("I ate It ")
                .fontWeight(.semibold)
                .foregroundColor(Color.black)
            Image(systemName: "fork.knife")
                .foregroundColor(Color.black)
                .tint(.black)
                .font(.body)
        }
    }
}
