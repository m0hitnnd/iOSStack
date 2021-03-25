//
//  HTTPMethod.swift
//  Hollywoo
//
//  Created by Mohitnnd on 24/03/21.
//

import Foundation

enum HttpMethod {
    case get
    case post(body: AnyEncodable)
    
    func toUrlRequestHttpMethod() -> String {
        switch self {
        case .get:
            return "get"
        case .post:
            return "post"
        }
    }
}
