//
//  WebService+Rx.swift
//  Hollywoo
//
//  Created by Mohitnnd on 24/03/21.
//

import Foundation
import RxSwift

extension WebService {
    func execute<T: Decodable>(_ request: Request, responseType: T.Type) -> Single<T?> {
        return Single.create { observer -> Disposable in
            let request = execute(request, responseType: responseType) { (response) in
                guard let model = response else {
                    observer(.success(nil))
                    return
                }
                observer(.success(model))
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
