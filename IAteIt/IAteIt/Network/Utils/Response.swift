//
//  Response.swift
//  IAteIt
//
//  Created by 박성수 on 1/27/24.
//

import Foundation

protocol Response: Decodable {
    associatedtype requestType: Request
    
    var status: Int { get set }
    var code: String { get set }
    var message: String { get set }
    
}

