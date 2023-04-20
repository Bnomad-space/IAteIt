//
//  SignUpSecondView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/04/06.
//

import SwiftUI

struct SignUpSecondView: View {
    @State private var imagePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @State private var isLaterTextPresented = true
    
    let imgSize: CGFloat = 148
    
    var body: some View {
        VStack {
            Text("Please upload your profile picture.")
                .font(.headline)
                .padding(.top, 60)
            Button(action: {
                imagePickerPresented.toggle()
            }, label: {
                if let image = profileImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: imgSize, height: imgSize)
                        .clipShape(Circle())
                } else {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imgSize, height: imgSize)
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: imgSize, height: imgSize)
                            .foregroundColor(Color(UIColor.systemGray2))
                    }
                    .clipShape(Circle())
                }
            })
            .sheet(isPresented: $imagePickerPresented,
                   onDismiss: loadImage,
                   content: { ImagePicker(image: $selectedImage) })
            .shadow(color: .black.opacity(0.20), radius: 10, x: 4, y: 4)
            .padding(.top, 40)
            
            Spacer()
            if isLaterTextPresented {
                Text("You can do this later!")
                    .font(.body)
                    .foregroundColor(Color(UIColor.systemGray))
                    .padding(.bottom, 20)
            }
            Button(action: {
                // TODO: 이미지 저장, SignUpView dismiss
            }, label: {
                BottomButtonView(label: "Done")
            })
        }
        .navigationBarHidden(true)
    }
}

extension SignUpSecondView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
        isLaterTextPresented = false
    }
}

struct SignUpSecondView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpSecondView()
    }
}