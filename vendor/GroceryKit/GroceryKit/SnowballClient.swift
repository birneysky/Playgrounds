//
//  SnowballClient.swift
//  GroceryKit
//
//  Created by Bruce on 2021/9/23.
//  Copyright © 2021 Grocery. All rights reserved.
//

import Foundation

struct StockItem: Decodable {
    var symbol: String /// 证券代码
    var net_profit_cagr: Double? /// 净利润复合年增长率
    var north_net_inflow: Double? /// 北上净流入
    var ps: Double? /// 市销率
    var type: Int ///
    var percent: Float? /// 涨跌幅
    var has_follow: Bool
    var tick_size: Float
    var pb_ttm: Float?
    var float_shares: Int
    var current: Float /// 当前价
    var amplitude: Float?
    var pcf: Double?
    var current_year_percent: Float? /// 年初到至今涨幅
    var float_market_capital: Int /// 流动资金
    var north_net_inflow_time: Int? /// 北上净流入时间
    var market_capital: Int /// 市值
    var dividend_yield: Float? /// 股息率
    var lot_size: Int
    var roe_ttm: Double?
    var total_percent: Float?
    var percent5m: Float?
    var income_cagr: Double?
    var amount: Double? /// 成交额
    var chg: Float? /// 涨跌额
    var issue_date_ts: Int64
    var eps: Float
    var main_net_inflows: Double?
    var volume: Int? /// 成交量
    var volume_ratio: Float? /// 量比
    var pb: Float? /// 市净率
    var followers: Int?
    var turnover_rate: Float? /// 换手率
    var first_percent: Float?
    var name: String /// 股票名
    var pe_ttm: Float? /// 市盈率 ttm
    var total_shares: Int /// 股份总数
    var limitup_days: Int?
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
