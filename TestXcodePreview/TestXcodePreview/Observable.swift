//
//  Observable.swift
//  ktv
//
//  Created by Bruce on 2023/9/12.
//

import Foundation


class KTVObservable<T> {
    
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind(_ listener: @escaping ((T?) -> Void)) {
        //listener(value)
        self.listener = listener
    }
}
