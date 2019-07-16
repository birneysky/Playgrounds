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

protocol Parseable {
   static func parse(data: Data) -> Self?
}

struct TokenResponse: Decodable {
    
}

struct TokenRequest: Request {
    typealias Token = String
    typealias Response = Token
    var userId: String
    var name: String
    let path = "/user/getToken.json"
    let method: HttpMethod = .POST
    let parameter: [String : Any] = [:]
    let appKey: String = "lmxuhwaglck9d"
    let appSecret: String = "t6ZKDZnULwLuC"
    var headers: [String : String]  {
        let random = arc4random()
        let timeStamp = time(nil)
        var bytes: [UInt8] = Array<UInt8>(repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
//        let digist = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(CC_SHA1_DIGEST_LENGTH))
//        digist.initialize(from: &bytes, count: Int(CC_SHA1_DIGEST_LENGTH))
        let digist = UnsafeMutablePointer<UInt8>(&bytes)
        let sumString = "\(appSecret)\(random)\(timeStamp)"
        guard let cChars = sumString.cString(using: .utf8) else {
            return [:]
        }
        var signature: String = ""
        CC_SHA1(cChars, CC_LONG(sumString.count), digist)
        for i in 0..<CC_SHA1_DIGEST_LENGTH {
            signature.append(String(format: "%02x", digist[Int(i)] & 0xFF))
        }
        //digist.deallocate()
        return ["App-Key":appKey,
                "Nonce":"\(random)",
                "Timestamp":"\(timeStamp)",
                "Signature":signature,
                "Content-Type":"application/x-www-form-urlencoded"]
    }
    func parse(data: Data) -> Token? {
        guard let obj  = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return nil
        }
        return nil
    }
    
    func encode() -> Data? {
        return "userId=\(userId)&name=\(name)".data(using: .utf8, allowLossyConversion: false)
    }
}
