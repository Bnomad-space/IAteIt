//
//  PlateImageErrorView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/07/12.
//

import SwiftUI

struct PlateImageErrorView: View {
    var iconSize: CGFloat
    
    var body: some View {
        VStack {
            Text("Error!")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(Color(UIColor.systemGray2))
            Image(systemName: "takeoutbag.and.cup.and.straw")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: iconSize)
                .foregroundColor(Color(UIColor.systemGray3))
        }
    }
}

struct PlateImageErrorView_Previews: PreviewProvider {
    static var previews: some View {
        PlateImageErrorView(iconSize: 48)
    }
}
