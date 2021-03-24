//
//  Request.swift
//  TMDB
//
//  Created by Mohitnnd on 24/03/21.
//

import Foundation

struct Request {
    let method: HttpMethod
    let url: String
}

extension Request {
    init(url: String) {
        self.url = url
        self.method = .get
    }
}

extension Request {
    func toURLRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = self.method.toUrlRequestHttpMethod()
        switch method {
        case .get: ()
        case .post(let body):
            request.httpBody = try! JSONEncoder().encode(body)
        }
        return request
    }
}
