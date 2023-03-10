//
//  tagOnPhotoView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/02/23.
//

import SwiftUI

struct TagOnPhotoView: View {
    var tagText: String
    var tagImage: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: tagImage)
                .font(.footnote)
            Text(tagText)
                .font(.footnote)
        }
        .padding(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10))
        .foregroundColor(.white)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .opacity(0.6)
        )
    }
}

struct TagOnPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        TagOnPhotoView(tagText: "맥도날드", tagImage: "location")
    }
}
