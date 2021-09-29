//
//  HttpClient.swift
//  GroceryKit
//
//  Created by birney on 2019/7/17.
//  Copyright © 2019 Grocery. All rights reserved.
//

import Foundation
import CommonCrypto

public struct FailedRequest: Error {
    let code: Int
    let errorMessage: String?
}


struct TokenResponse: Decodable , Parseable {
    let token: String?
    let code: Int
    let userId: String?
    let url: String?
    let errorMessage: String?
    static func parse(data: Data) -> TokenResponse? {
        var response: TokenResponse?
        do {
            response = try JSONDecoder().decode(TokenResponse.self, from: data)
        } catch {
            print("\(self.self) parase error: \(error).")
        }
        return response
    }
}


struct TokenRequest: Request {
    typealias ResponseData = TokenResponse
    var userId: String
    var name: String
    let path = "/user/getToken.json"
    let method: HttpMethod = .POST
    let parameter: [String : Any]? = [:]
    let appKey: String = "lmxuhwaglck9d"
    let appSecret: String = "t6ZKDZnULwLuC"
    var headers: [String : String]?  {
        let random = arc4random()
        let timeStamp = time(nil)
        var bytes: [UInt8] = Array<UInt8>(repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        let digist = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        digist.initialize(from: &bytes, count: Int(CC_SHA1_DIGEST_LENGTH))
        //let digist = UnsafeMutablePointer<UInt8>(&bytes)
        let sumString = "\(appSecret)\(random)\(timeStamp)"
        guard let cChars = sumString.cString(using: .utf8) else {
            return [:]
        }
        var signature: String = ""
        CC_SHA1(cChars, CC_LONG(cChars.count-1), digist)
        for i in 0..<CC_SHA1_DIGEST_LENGTH {
            signature.append(String(format: "%02x", digist[Int(i)] & 0xFF))
        }
        digist.deallocate()
        return ["App-Key":appKey,
                "Nonce":"\(random)",
                "Timestamp":"\(timeStamp)",
                "Signature":signature,
                "Content-Type":"application/x-www-form-urlencoded"]
    }

    func encode() -> Data? {
        return "userId=\(userId)&name=\(name)".data(using: .utf8, allowLossyConversion: false)
    }
}

public class RongCloudClient {
    private let client: URLSessionClient = URLSessionClient(host: "https://api.cn.ronghub.com")
    
    func fetchToken(uid: String, name: String) -> Promise<String> {
        let req = TokenRequest(userId: uid, name: name)
        return Promise<String> { resolve in
            client.send(req) { responseData, response, error in
                if let token = responseData?.token {
                    resolve.fulfill(token)
                } else if let err = error {
                    resolve.reject(err)
                } else {
                    guard let aData = responseData else {
                        fatalError("token request no error message")
                    }
                    let fail = FailedRequest(code: aData.code, errorMessage: aData.errorMessage)
                    resolve.reject(fail)
                }
            }
        }
    }
}


