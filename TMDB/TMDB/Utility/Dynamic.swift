//
//  Dynamic.swift
//  TMDB
//
//  Created by Mohitnnd on 23/03/21.
//

import Foundation

final class Dynamic<T> {
    
    private var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        self.closure = closure
    }
    
    func bindAndFire(_ closure: @escaping (T) -> Void) {
        self.closure = closure
        self.closure?(value)
    }
}
