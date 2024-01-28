//
//  Request.swift
//  IAteIt
//
//  Created by 박성수 on 1/27/24.
//

import Foundation

protocol Request {
    associatedtype responseType: Response
    
    var method: HttpMethod { get set }
    func urlRequest(url: URL) -> URLRequest
}

