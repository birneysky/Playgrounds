//
//  KlineRequest.swift
//  GroceryKit
//
//  Created by Bruce on 2021/9/27.
//  Copyright © 2021 Grocery. All rights reserved.
//

import Foundation

struct KLineRequest: Request {
    typealias Response = KlineResponse
    var path: String {
        let begin:Int = Int(NSDate().timeIntervalSince1970 * 1000)
        let klinePath = "/v5/stock/chart/kline.json?"
        let indicator = "indicator=kline,pe,pb,ps,pcf,market_capital,agt,ggt,balance"
        return "\(klinePath)symbol=\(symbol)&begin=\(1632811713380)&period=day&type=before&count=\(offset)&\(indicator)"
    }
    
    var method: HttpMethod {
        .GET
    }
    
    var symbol: String
    var offset: Int
}

struct KlineResponse: Decodable, Parseable {
    var error_code: Int
    var error_description: String
    var data: KlineData?
    
    static func parse(data: Data) throws -> KlineResponse  {
        do {
            let s = String(data: data, encoding: .utf8);
            let response = try JSONDecoder().decode(KlineResponse.self, from: data)
            return response
        } catch  {
            print("Unexpected error: \(error).")
            throw error
        }
    }
}

struct KlineData: Decodable {
    var symbol: String
    var column: [String]
    var items: [[Double?]]
    
    func allKlineItems() throws ->  [KlineItem] {
        var result = [KlineItem]()
        for values in items {
            assert(values.count == column.count)
            guard values.count == column.count else {
                fatalError("data format error")
            }
            var itemDic = Dictionary<String, Any?>()
            for i in 0 ..< values.count {
                itemDic[column[i]] = values[i]
            }
            do {
                 let data = try JSONSerialization.data(withJSONObject: itemDic, options: [])
                 let klineItem = try JSONDecoder().decode(KlineItem.self, from: data)
                 result.append(klineItem);
            } catch  {
                print("Unexpected error: \(error).")
                throw error
            }
            
            
        }
        return result
    }
}

struct KlineItem: Decodable {
    var timestamp: Int64
    var volume: Int
    var open: Float
    var high: Float
    var low: Float
    var close: Float
    var chg:Float
    var percent: Float
    var turnoverrate: Float
    var amount: Double
    var volume_post: Int?
    var amount_post: Double?
    var pe: Float?
    var pb: Float?
    var ps: Float?
    var pcf: Float?
    var market_capital: Double
    var balance: Double
    var hold_volume_cn: Int?
    var hold_ratio_cn: Float?
    var net_volume_cn: Int?
    var hold_volume_hk: Int?
    var hold_ratio_hk: Float?
    var net_volume_hk: Int?
}
