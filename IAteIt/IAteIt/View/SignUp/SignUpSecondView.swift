//
//  SignUpSecondView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/04/06.
//

import SwiftUI

struct SignUpSecondView: View {
    let imgSize: CGFloat = 148
    
    var body: some View {
        VStack {
            Text("Please upload your profile picture.")
                .font(.headline)
                .padding(.top, 60)
            Button(action: {
                // TODO: 이미지 선택
            }, label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imgSize, height: imgSize)
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFill()
                        .layoutPriority(-1)
                        .frame(width: imgSize, height: imgSize)
                        .foregroundColor(Color(UIColor.systemGray2))
                }
                .clipped()
                .cornerRadius(imgSize/2)
            })
            .shadow(color: .black.opacity(0.20), radius: 10, x: 4, y: 4)
            .padding(.top, 40)
            
            Spacer()
            Text("You can do this later!")
                .font(.body)
                .foregroundColor(Color(UIColor.systemGray))
                .padding(.bottom, 20)
            Button(action: {
                // TODO: 이미지 저장, dismiss
            }, label: {
                BottomButtonView(label: "Done")
            })
        }
        .navigationBarHidden(true)
    }
}

struct SignUpSecondView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpSecondView()
    }
}
