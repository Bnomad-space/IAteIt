//
//  EmptyMealView.swift
//  IAteIt
//
//  Created by Beone on 2023/05/11.
//

import SwiftUI

struct EmptyMealView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("emptyMealIcon")
            Text("Aren't you hungry?")
                .font(.footnote)
                .fontWeight(.regular)
                .foregroundColor(.gray)
        }
    }
}
