//
//  SnowballClient.swift
//  GroceryKit
//
//  Created by Bruce on 2021/9/23.
//  Copyright © 2021 Grocery. All rights reserved.
//

import Foundation

struct StockItem: Decodable {
    var symbol: String
    var net_profit_cagr: Double?
    var north_net_inflow: Double?
    var ps: Double
    var type: Int
    var percent: Float
    var has_follow: Bool
    var tick_size: Float
    var pb_ttm: Float?
    var float_shares: Int
    var current: Float
    var amplitude: Float
    var pcf: Double?
    var current_year_percent: Float
    var float_market_capital: Int
    var north_net_inflow_time: Int?
    var market_capital: Int
    var dividend_yield: Float?
    var lot_size: Int
    var roe_ttm: Double
    var total_percent: Float
    var percent5m: Float
    var income_cagr: Double
    var amount: Double
    var chg: Float
    var issue_date_ts: Int64
    var eps: Float
    var main_net_inflows: Double
    var volume: Int
    var volume_ratio: Float
    var pb: Float
    var followers: Int
    var turnover_rate: Float
    var first_percent: Float
    var name: String
    var pe_ttm: Float?
    var total_shares: Int
    var limitup_days: Int
}

struct TopAmountData: Decodable {
    var count: Int
    var list: [StockItem]
}

struct TopAmountResponse: Decodable, Parseable {
    var data: TopAmountData
    var error_code: Int
    var error_description: String
    static func parse(data: Data) throws -> TopAmountResponse  {
        do {
            let response = try JSONDecoder().decode(TopAmountResponse.self, from: data)
            return response
        } catch  {
            print("Unexpected error: \(error).")
            throw error
        }
    }
    
    
}

struct TopAmountRequest: Request {
    typealias Response = TopAmountResponse
    
    var headers: [String : String]? {
        return nil
    }
        
    var path: String {
        var aTime:time_t = 0;
        let listPath = "/service/v5/stock/screener/quote/list?"
        let orderPath = "order=desc&orderby=amount&order_by=amount&market=CN&type=sh_sz"
        return "\(listPath)page=\(page)&size=\(pageSize)&\(orderPath)&_=\(time(&aTime))"
    }
    
    var method: HttpMethod {
        .GET
    }
    
    var parameter: [String : Any]? {
        nil
    }
    
    func encode() -> Data? {
        nil
    }
    
    var page: Int
    var pageSize: Int
    
    
}


class SnowballClient {
    
    private let client: URLSessionClient = URLSessionClient(host: "https://xueqiu.com")
    
    func fetchTopAmountStocks (count: Int) -> Promise<[StockItem]> {
        let req = TopAmountRequest(page: 1, pageSize: count)
        return Promise<[StockItem]> { resolve in
            client.send(req) { response, error in
                if let list = response?.data.list {
                    resolve.fulfill(list)
                } else if let err = error {
                    resolve.reject(err)
                } else {
                    guard let aresponse = response else {
                        fatalError("token request no error message")
                    }
                    let fail = FailedRequest(code: aresponse.error_code, errorMessage: aresponse.error_description)
                    resolve.reject(fail)
                }
            }
        }
    }
    
}
