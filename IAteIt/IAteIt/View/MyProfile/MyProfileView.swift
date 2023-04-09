//
//  MyProfileView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI

struct MyProfileView: View {
    
    let paddingLR: CGFloat = 16
    
    var body: some View {
        ScrollView {
            VStack {
                ProfileCellView()
                MealListView()
            }
        }
        .padding([.leading, .trailing], paddingLR)
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
