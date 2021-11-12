//
//  Client.swift
//  GroceryKit
//
//  Created by birney on 2019/7/16.
//  Copyright © 2019 Grocery. All rights reserved.
//

import Foundation

protocol Client {
    func send<T: Request>(_ r: T, handler: @escaping (T.ResponseData?, URLResponse?, Error?) -> Void )
    
    var host: String { get }
}

struct URLSessionClient: Client {
    var host: String
    
    func send<T: Request>(_ r: T, handler: @escaping (T.ResponseData?, URLResponse?, Error?) -> Void) {
        let url = URL(string: host + r.path)
        var request = URLRequest(url: url!)
        request.httpMethod = r.method.rawValue
        request.httpBody = r.encode()
        if let headers = r.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            var modelData: T.ResponseData?
            if let aData = data { modelData = T.ResponseData.parse(data: aData) }
            DispatchQueue.main.async { handler(modelData, response, error) }
//            if let data = data {
//                do {
//                    let res = try T.Response.parse(data: data)
//                    DispatchQueue.main.async { handler(res,error) }
//                } catch  {
//                    print("Unexpected error: \(error).")
//                    DispatchQueue.main.async { handler(nil,error) }
//                }
//            } else {
//                DispatchQueue.main.async { handler(nil,error) }
//            }
        }
        task.resume()
    }
}

