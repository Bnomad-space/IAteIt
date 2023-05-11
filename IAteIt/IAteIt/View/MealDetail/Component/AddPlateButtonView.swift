//
//  AddPlateButtonView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/05/11.
//

import SwiftUI

struct AddPlateButtonView: View {
    
    var body: some View {
        HStack {
            Image(systemName: "camera.fill")
            Text("Add a plate")
                .fontWeight(.semibold)
        }
        .font(.subheadline)
        .foregroundColor(.white)
        .padding(EdgeInsets(top: 6, leading: 13, bottom: 6, trailing: 13))
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.black)
        )
    }
}

struct AddPlateButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlateButtonView()
    }
}
