//
//  JwtRequired.swift
//  IAteIt
//
//  Created by 박성수 on 1/29/24.
//

import Foundation

protocol JwtRequired {
    var jwtToken: String { get set }
    
}
