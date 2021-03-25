//
//  WebService.swift
//  Hollywoo
//
//  Created by Mohitnnd on 24/03/21.
//

import Foundation

struct WebService {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func execute<T: Decodable>(_ request: Request,
                               responseType: T.Type,
                               completionHandler: @escaping ((T?) -> ())
    ) -> URLSessionDataTask {
        let task =  urlSession.dataTask(with: request.toURLRequest()) { (data, _, _) in
            guard let data = data else {
                completionHandler(nil)
                return
            }
            completionHandler(try? JSONDecoder().decode(responseType, from: data))
        }
        task.resume()
        return task
    }
}
