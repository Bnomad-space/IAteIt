//
//  UsernameValidModel.swift
//  IAteIt
//
//  Created by 박성수 on 5/7/24.
//

import Foundation
import SwiftUI

class UsernameValidModel: ObservableObject {
    @Published var text: String = ""
    @Published var isValidFormat: Bool = false
    @Published var isUnique: Bool = true
    @Published var usernameList: [String] = []
    
    init() {
        getUsernameList()
    }
    
    func getUsernameList() {
        Task {
            self.usernameList = try await FirebaseConnector.shared.fetchAllUsernames()
        }
    }
    
    func textCount() -> Int {
        return text.count
    }
    
    func updateConstraints() {
        self.text = text.replacingOccurrences(of: " ", with: "")
        self.isValidFormat = testValidUsername(testString: text)
        self.isUnique = testUnique(testString: text)
    }
    
    func testValidUsername(testString: String?) -> Bool {
        let regEx = "^[a-zA-Z][a-zA-Z0-9]{3,15}$"
        let usernameTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        return usernameTest.evaluate(with: testString)
    }
    
    func testUnique(testString: String) -> Bool {
        if usernameList.contains(testString.lowercased()) {
            return false
        } else {
            return true
        }
    }
    
    func textValidColor() -> Color {
        let countValue = textCount()
        if countValue == 0 {
            return .gray
        }
        if countValue >= 4 {
            return .green
        }
        return .red
    }
    
    func buttonDisable() -> Bool {
        return !isValidFormat || !isUnique
    }
    
    func ifIsUnique() -> Bool {
        return isUnique
    }
}
