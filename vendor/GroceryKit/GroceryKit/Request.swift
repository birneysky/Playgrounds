//
//  Request.swift
//  GroceryKit
//
//  Created by birney on 2019/7/16.
//  Copyright © 2019 Grocery. All rights reserved.
//

import Foundation
import CommonCrypto

enum HttpMethod: String {
    case GET
    case POST
}

protocol Request {
    var path: String { get }
    
    var method: HttpMethod { get }
    var headers: [String: String] { get }
    var parameter: [String: Any] { get }
    
    associatedtype Response
    func encode() -> Data?
    func parse(data: Data) -> Response?
}

extension Request {
    var headers:[String: String]  {
        [:]
    }
}

struct TokenRequest: Request {
    typealias Token = String
    typealias Response = Token
    var userId: String
    var name: String
    let path = "/user/getToken.json"
    let method: HttpMethod = .POST
    let parameter: [String : Any] = [:]
    let appKey: String = "c9kqb3rdkbb8j"
    let appSecret: String = "OYjzdrxMmUOmq"
    var headers: [String : String]  {
        let random = arc4random()
        let timeStamp = time(nil)
        let digist = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        let sumString = String(format: "%@%u%ld", appSecret,random,timeStamp)
        guard let cChars = sumString.cString(using: .utf8) else {
            return [:]
        }
        var signature: String = ""
        CC_SHA1(UnsafeRawPointer(cChars), CC_LONG(cChars.count), digist)
        for i in 0...CC_SHA1_DIGEST_LENGTH {
            signature.append(String(format: "%02x", digist[Int(i)] & 0xFF))
        }
        return ["App-Key":appKey,
                "Nonce":"\(random)",
                "Timestamp":"\(timeStamp)",
                "Signature":signature]
    }
    func parse(data: Data) -> Token? {
        return nil
    }
    
    func encode() -> Data? {
        return "userId=\(userId)&name=\(name)".data(using: .utf8)
    }
}
