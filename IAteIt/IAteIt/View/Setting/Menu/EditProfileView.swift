//
//  EditProfileView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/05/12.
//

import SwiftUI

struct EditProfileView: View {
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
                .padding(.top, 22)
                
                VStack {
                    HStack {
                        HStack {
                            Text("Username")
                                .font(.body)
                            Spacer()
                        }
                        .frame(width: 112)
                        // TODO: textField에 본인 username 넣어두기
                        TextField("username", text: $username)
                            .limitTextLength($username, to: 16)
                            .textCase(.lowercase)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .font(.body)
                            .focused($isFocused)
                            .onAppear {
                                UITextField.appearance().clearButtonMode = .whileEditing
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
        .navigationTitle("Edit Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                   // TODO: 프로필 수정 내용 저장
                }, label: {
                   Text("Save")
                       .font(.headline)
                })
                .disabled(
                    !isValidFormat || !isUnique
                )
            }
        }
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
        if usernameList.contains(testString) {
            // TODO: usernameList에서 본인 username은 빼고 체크
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
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
