//
//  SignUpSecondView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/04/06.
//

import SwiftUI

struct SignUpSecondView: View {
    @ObservedObject var loginState: LoginStateModel
    @EnvironmentObject var feedMeals: FeedMealModel
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
                        .circleImage(imageSize: imgSize)
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
                saveAndCompleteSignUp()
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
    func saveAndCompleteSignUp() {
        var user = User(id: loginState.appleUid, nickname: loginState.username)
        Task {
            if let image = selectedImage {
                let imageUrl = try await FirebaseConnector.shared.uploadProfileImage(userId: loginState.appleUid, image: image)
                user.profileImageUrl = imageUrl
            }
            try await FirebaseConnector.shared.setNewUser(user: user)
            await MainActor.run {
                loginState.user = user
                loginState.isSignUpRequired = false
                loginState.isAppleLoginRequired = false
                feedMeals.refreshMealsAndUsers()
            }
        }
    }
}

struct SignUpSecondView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpSecondView(loginState: LoginStateModel())
    }
}
