//
//  HttpClient.swift
//  GroceryKit
//
//  Created by birney on 2019/7/17.
//  Copyright © 2019 Grocery. All rights reserved.
//

import Foundation

public struct FailedRequest: Error {
    let code: Int
    let errorMessage: String?
}

public class HtppClient {
    private let client: URLSessionClient = URLSessionClient()
    
    func fetchToken(uid: String, name: String) -> Promise<String> {
        let req = TokenRequest(userId: uid, name: name)
        return Promise<String> { resolve in
            client.send(req) { response, error in
                if let token = response?.token {
                    resolve.fulfill(token)
                } else if let err = error {
                    resolve.reject(err)
                } else {
                    guard let aresponse = response else {
                        fatalError("token request no error message")
                    }
                    let fail = FailedRequest(code: aresponse.code, errorMessage: aresponse.errorMessage)
                    resolve.reject(fail)
                }
            }
        }
    }
}
