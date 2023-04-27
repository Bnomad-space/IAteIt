//
//  SignUpState.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/04/26.
//

import Foundation

class SignUpState: ObservableObject {
    @Published var isPresent: Bool = false
    @Published var username: String = ""
}
