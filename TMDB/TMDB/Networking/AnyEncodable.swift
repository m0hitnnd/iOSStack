//
//  AnyEncodable.swift
//  TMDB
//
//  Created by Mohitnnd on 24/03/21.
//

import Foundation

struct AnyEncodable: Encodable {
    let body: Encodable
    init(_ body: Encodable) {
        self.body = body
    }
    
    func encode(to encoder: Encoder) throws {
        try body.encode(to: encoder)
    }
}
