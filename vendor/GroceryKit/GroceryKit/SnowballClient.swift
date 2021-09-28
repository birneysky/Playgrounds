//
//  SnowballClient.swift
//  GroceryKit
//
//  Created by Bruce on 2021/9/23.
//  Copyright © 2021 Grocery. All rights reserved.
//

import Foundation

class SnowballClient {
    func fetchTopAmountStocks (count: Int) -> Promise<[StockItem]> {
        let client: URLSessionClient = URLSessionClient(host: "https://xueqiu.com")
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
    ///https://stock.xueqiu.com/v5/stock/chart/kline.json?symbol=SH600111&begin=1632811713380&period=day&type=before&count=-284&indicator=kline,pe,pb,ps,pcf,market_capital,agt,ggt,balance
    func fetchKline(of stock: String ) -> Promise<[KlineItem]> {
        //let client: URLSessionClient = URLSessionClient(host: "stock.xueqiu.com")
        let client: URLSessionClient = URLSessionClient(host: "https://stock.xueqiu.com")
        let req = KLineRequest(symbol: "SH600111", offset: -284)
        return Promise<[KlineItem]> { resolve in
            client.send(req) { response, error in
                let klineItems = try? response?.data?.allKlineItems()
                if let items = klineItems {
                    resolve.fulfill(items)
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
