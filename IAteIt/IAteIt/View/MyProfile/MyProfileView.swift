//
//  MyProfileView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/22.
//

import SwiftUI

struct MyProfileView: View {
    
    let paddingLR: CGFloat = 16
    let profileImgSize: CGFloat = 120
    
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: profileImgSize, height: profileImgSize)
                Image("Sample_Profile1")
                    .resizable()
                    .scaledToFill()
                    .layoutPriority(-1)
            }
            .clipped()
            .cornerRadius(profileImgSize/2)

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
