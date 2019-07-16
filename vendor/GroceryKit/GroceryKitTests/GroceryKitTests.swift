//
//  GroceryKitTests.swift
//  GroceryKitTests
//
//  Created by birneysky on 2019/7/15.
//  Copyright © 2019 Grocery. All rights reserved.
//

import XCTest
@testable import GroceryKit

class GroceryKitTests: XCTestCase {
    var client: URLSessionClient!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        client = URLSessionClient()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        client = nil
    }

    func test_TokenRequest() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        guard let url = URL(string: "http://apiqa.cn.ronghub.com/user/getToken.json") else {
            return
        }
        let req = TokenRequest()
        client.send(req) { (token) in
            print(token)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
