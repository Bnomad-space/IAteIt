//
//  PlateCountView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/06/27.
//

import SwiftUI

struct PlateCountView: View {
    var plates: [Plate]
    
    var body: some View {
        if plates.count > 1 {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
                    .opacity(0.6)
                    .padding()
                Text("+\(plates.count - 1)")
                    .font(.footnote)
                    .foregroundColor(.white)
            }
        }
    }
}
