//
//  MyProfileView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI

struct MyProfileView: View {

    var body: some View {
        GeometryReader { g in
            ScrollView {
                VStack {
                    ProfileCellView()
                    MealListView()
                }
                .frame(width: g.size.width - 5, height: g.size.height - 5, alignment: .center)
            }
        }

    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
