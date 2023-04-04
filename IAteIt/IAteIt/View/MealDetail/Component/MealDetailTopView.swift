//
//  MealDetailTopView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/04/04.
//

import SwiftUI

struct MealDetailTopView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 6) {
                    HStack {
                        Spacer()
                        Text("2 hours ago")
                            .font(.footnote)
                            .foregroundColor(Color(UIColor.systemGray))
                    }
                    Text("맥모닝 맛있다")
                        .font(.headline)
                    HStack(alignment: .center, spacing: 4) {
                        Image(systemName: "location.fill")
                        Text("맥도날드")
                    }
                    .font(.subheadline)
                }
    }
}

struct MealDetailTopView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailTopView()
    }
}
