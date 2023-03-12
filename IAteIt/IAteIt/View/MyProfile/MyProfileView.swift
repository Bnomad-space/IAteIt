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
        VStack {
            Circle()
                .frame(width: 122, height: 122)
                .padding(20)
            
            ScrollView(.vertical, showsIndicators: false) {
                DailyMealCellView()

            }
            
        }
        .padding([.leading, .trailing], paddingLR)
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
