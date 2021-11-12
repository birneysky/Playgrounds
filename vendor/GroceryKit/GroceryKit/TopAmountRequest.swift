//
//  TopAmountRequest.swift
//  GroceryKit
//
//  Created by Bruce on 2021/9/27.
//  Copyright © 2021 Grocery. All rights reserved.
//

import Foundation

struct TopAmountRequest: Request {
    typealias ResponseData = TopAmountStockInfo
    var path: String {
        let aTime: Int = Int(NSDate().timeIntervalSince1970);
        let listPath = "/service/v5/stock/screener/quote/list?"
        let orderPath = "order=desc&orderby=amount&order_by=amount&market=CN&type=sh_sz"
        
        return "\(listPath)page=\(page)&size=\(pageSize)&\(orderPath)&_=\(aTime))"
    }
    
    var method: HttpMethod {
        .GET
    }

    var page: Int
    var pageSize: Int
}

struct TopAmountStockInfo: Decodable, Parseable {
    var data: TopAmountStocRank
    var error_code: Int
    var error_description: String
    static func parse(data: Data)  -> TopAmountStockInfo?  {
        var response: TopAmountStockInfo?
        do {
            response = try JSONDecoder().decode(TopAmountStockInfo.self, from: data)
        } catch  {
            print("Unexpected error: \(error).")
        }
        return response
    }
}

struct StockTradingData: Decodable {
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
    var eps: Float?
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

struct TopAmountStocRank: Decodable {
    var count: Int
    var list: [StockTradingData]
}

