//
//  EditProfileView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/05/12.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var loginState: LoginStateModel
    @State private var isShowingSaveAlert = false
    @State private var imagePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @State var username = ""
    @State var isValidFormat: Bool = false
    @State var isUnique: Bool = true
    @State var usernameList: [String] = []
    @FocusState var isFocused: Bool
    
    let imgSize: CGFloat = 122
    
    var body: some View {
        ScrollView {
            VStack {
                Button(action: {
                    imagePickerPresented.toggle()
                }, label: {
                    if let newImage = profileImage {
                        newImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: imgSize, height: imgSize)
                            .clipShape(Circle())
                    } else {
                        if let oldImageUrl = loginState.user?.profileImageUrl {
                            AsyncImage(url: URL(string: oldImageUrl)) { oldImage in
                                oldImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: imgSize, height: imgSize)
                                    .clipShape(Circle())
                            } placeholder: {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: imgSize, height: imgSize)
                                    .foregroundColor(Color(UIColor.systemGray2))
                                    .clipShape(Circle())
                            }
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
                    }
                })
                .sheet(isPresented: $imagePickerPresented,
                       onDismiss: loadImage,
                       content: { ImagePicker(image: $selectedImage) })
                .shadow(color: .black.opacity(0.20), radius: 10, x: 4, y: 4)
                .padding(.top, 22)
                
                VStack {
                    HStack {
                        HStack {
                            Text("Username")
                                .font(.body)
                            Spacer()
                        }
                        .frame(width: 112)
                        
                        TextField("username", text: $username)
                            .limitTextLength($username, to: 16)
                            .textCase(.lowercase)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .font(.body)
                            .focused($isFocused)
                            .onAppear {
                                UITextField.appearance().clearButtonMode = .whileEditing
                                guard let oldUsername = loginState.user?.nickname else { return }
                                username = oldUsername
                            }
                            .onChange(of: username) { _ in
                                username = username.replacingOccurrences(of: " ", with: "")
                                isValidFormat = testValidUsername(testString: username)
                                isUnique = testUnique(testString: username)
                            }
                    }
                    Rectangle()
                        .frame(height: 0.75)
                        .foregroundColor(Color(UIColor.systemGray3))
                }
                .padding(.top, 64)
                .padding(.horizontal, .paddingHorizontal)
            }
        }
        .onTapGesture {
            self.hideKeyboard()
        }
        .onAppear {
            getAllUsernames()
        }
        .navigationTitle("Edit Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    saveProfile()
                    isShowingSaveAlert = true
                }, label: {
                   Text("Save")
                       .font(.headline)
                })
                .disabled(
                    !isValidFormat || !isUnique
                )
            }
        }
        .alert("Changes Saved", isPresented: $isShowingSaveAlert, actions: {
            Button("OK", role: .cancel, action: {
                self.presentationMode.wrappedValue.dismiss()
            })
        }, message: {
            Text("Your changed have been saved successfully.")
        })
    }
}

extension EditProfileView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
    func testValidUsername(testString: String?) -> Bool {
        let regEx = "^[a-zA-Z][a-zA-Z0-9]{3,15}$"
        let usernameTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        return usernameTest.evaluate(with: testString)
    }
    func testUnique(testString: String) -> Bool {
        var takenUsernameList = usernameList
        takenUsernameList.removeAll(where: { $0 == loginState.user?.nickname })
        if takenUsernameList.contains(testString) {
            return false
        } else {
            return true
        }
    }
    func getAllUsernames() {
        FirebaseConnector.shared.fetchAllUsernames { list in
            self.usernameList = list
        }
    }
    func saveProfile() {
        guard let userId = loginState.user?.id else { return }
        var user = User(id: userId, nickname: self.username, profileImageUrl: loginState.user?.profileImageUrl)
        Task {
            if let image = selectedImage {
                let newProfileImageUrl = try await FirebaseConnector.shared.uploadProfileImage(userId: userId, image: image)
                user.profileImageUrl = newProfileImageUrl
            }
            DispatchQueue.main.async {
                loginState.user = user
            }
            try await FirebaseConnector.shared.updateUser(user: user)
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
