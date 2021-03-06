//
//  Client.swift
//  GroceryKit
//
//  Created by birney on 2019/7/16.
//  Copyright © 2019 Grocery. All rights reserved.
//

import Foundation

protocol Client {
    func send<T: Request>(_ r: T, handler: @escaping (T.Response?, Error?) -> Void )
    
    var host: String { get }
}

struct URLSessionClient: Client {
    let host: String = "https://api.cn.ronghub.com"
    
    func send<T: Request>(_ r: T, handler: @escaping (T.Response?, Error?) -> Void) {
        let url = URL(string: host + r.path)
        var request = URLRequest(url: url!)
        request.httpMethod = r.method.rawValue
        request.httpBody = r.encode()
        for (key, value) in r.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let data = data, let res = T.Response.parse(data: data) {
                DispatchQueue.main.async { handler(res,nil) }
            } else {
                DispatchQueue.main.async { handler(nil,error) }
            }
        }
        task.resume()
    }
}

