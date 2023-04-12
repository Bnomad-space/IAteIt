//
//  BottomButtonView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/04/06.
//

import SwiftUI

struct BottomButtonView: View {
    var label: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .accentColor(.black)
            Text(label)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(width: 350, height: 48)
        .padding(.bottom, 12)
    }
}
