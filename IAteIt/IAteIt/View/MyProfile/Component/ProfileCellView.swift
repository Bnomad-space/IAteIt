//
//  ProfileCellView.swift
//  IAteIt
//
//  Created by Youngwoong Choi on 2023/04/08.
//

import SwiftUI

struct ProfileCellView: View {
    
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
            
            Text("\(User.user1.nickname)")
            
        }

    }
}

struct ProfileCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCellView()
    }
}
