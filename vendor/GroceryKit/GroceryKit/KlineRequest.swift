//
//  KlineRequest.swift
//  GroceryKit
//
//  Created by Bruce on 2021/9/27.
//  Copyright © 2021 Grocery. All rights reserved.
//

import Foundation

struct KLineRequest: Request {
    typealias ResponseData = KlineInfo
    var path: String {
        let begin:Int = Int(NSDate().timeIntervalSince1970 * 1000)
        let klinePath = "/v5/stock/chart/kline.json?"
        let indicator = "indicator=kline,pe,pb,ps,pcf,market_capital,agt,ggt,balance"
        return "\(klinePath)symbol=\(symbol)&begin=\(begin)&period=day&type=before&count=\(offset)&\(indicator)"
    }
    
    var method: HttpMethod {
        .GET
    }
    
    var headers: [String : String]? {
        return ["cookie":"xq_a_token=737318e45e37283c174e6861710dab688eebe737; xqat=737318e45e37283c174e6861710dab688eebe737; xq_r_token=396a59ce874f08fc58c8d546dffacc59ee1b372b; xq_id_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJ1aWQiOi0xLCJpc3MiOiJ1YyIsImV4cCI6MTYzNDU3ODI5NCwiY3RtIjoxNjMyMzcxMzIyNDkxLCJjaWQiOiJkOWQwbjRBWnVwIn0.SPbd3ovKnjswCLZCApOEjGlC33vhGvPClGNsW7AcC25yaxJtJPHjZxxOZl6MfSFrT2MsvK5NsCcNgGtWFdtIMLlXPItmpakYccXWI3VEEjF8Thmy-AMIo6F75wY5th8U1vPZvdpJDWrEY4sPoJ3qUrV7kawSrW-9B32SyGzFNb-lvhAAsT8RMZOf40EkP-6Gi-3E8mR94pwX0xQDvJWZE3OJ4eOWePn2RnPMGLNau1qZ6HYFXE0VzyXM3_FTZRQ746h6KPAalXvi-MLpLUbWuHdzAdFbWbBzAKL2iHc8XYPMw9Xqq7ot6bpLneolPh_1VKOWLLFxJtoZhMJiviw5fw; u=611632371350044; device_id=8a6a18c3bf78568bcb424479957e7f31; s=ct12cu6by9;"]
    }
    
    var symbol: String
    var offset: Int
}

struct KlineInfo: Decodable, Parseable {
    var error_code: Int
    var error_description: String
    var data: KlineData?
    
    static func parse(data: Data)  -> KlineInfo?  {
        var response: KlineInfo?
        do {
            response = try JSONDecoder().decode(KlineInfo.self, from: data)
        } catch  {
            print("Unexpected error: \(error).")
        }
        return response
    }
}

struct KlineData: Decodable {
    var symbol: String
    var column: [String]
    var item: [[Double?]]
    
    func allKlineItems() throws ->  [KlinePoint] {
        var result = [KlinePoint]()
        for values in item {
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
                 let klineItem = try JSONDecoder().decode(KlinePoint.self, from: data)
                 result.append(klineItem);
            } catch  {
                print("Unexpected error: \(error).")
                throw error
            }
            
            
        }
        return result
    }
}

struct KlinePoint: Decodable {
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
    var balance: Double?
    var hold_volume_cn: Int?
    var hold_ratio_cn: Float?
    var net_volume_cn: Int?
    var hold_volume_hk: Int?
    var hold_ratio_hk: Float?
    var net_volume_hk: Int?
}
