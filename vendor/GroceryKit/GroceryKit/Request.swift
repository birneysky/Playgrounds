//
//  Request.swift
//  GroceryKit
//
//  Created by birney on 2019/7/16.
//  Copyright © 2019 Grocery. All rights reserved.
//

import Foundation

enum HttpMethod: String {
    case GET
    case POST
}

protocol Parseable {
    static func parse(data: Data) throws -> Self 
}

protocol Request {
    var path: String { get }
    
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
    var parameter: [String: Any]? { get }
    
    associatedtype Response: Parseable
    func encode() -> Data?
}


extension Request {
    var headers: [String: String]?  {
        return nil
    }
    
    var parameter: [String: Any]? {
        return nil
    }
    
    func encode() -> Data? {
        nil
    }
}

