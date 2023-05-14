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
            Image(systemName: "takeoutbag.and.cup.and.straw")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 48)
                .foregroundColor(.gray)
            Text("Aren't you hungry?")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
        }
    }
}
