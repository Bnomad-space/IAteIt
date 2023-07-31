//
//  FeedTitleView.swift
//  IAteIt
//
//  Created by Beone on 2023/03/08.
//

import SwiftUI

struct FeedTitleView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(uiImage: UIImage(named: "AppLogo80x80")!)
                .resizable()
                .frame(width: 24, height: 24)
            Text("I ate it.")
                .fontWeight(.semibold)
        }
    }
}
