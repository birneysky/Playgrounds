//
//  SnowballClientTests.swift
//  GroceryKitTests
//
//  Created by Bruce on 2021/9/23.
//  Copyright © 2021 Grocery. All rights reserved.
//

import XCTest
@testable import GroceryKit

class SnowballClientTests: XCTestCase {
    var client: SnowballClient!
    var e: XCTestExpectation!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.client = SnowballClient()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.client = nil
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.e = self.expectation(description: "SnowballClientTests exception")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchTopAmountStocks() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        firstly {
            self.client.fetchTopAmountStocks(count: 200)
        }.done { list in
            print("\(list)")
            self.e.fulfill()
        }.catch { err in
            XCTAssert(false)
            print(err)
        }

        
        self.waitForExpectations(timeout: 30) { (error) in
            if let err = error {
                print(err)
                XCTAssert(false)
            } else {

            }

        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
