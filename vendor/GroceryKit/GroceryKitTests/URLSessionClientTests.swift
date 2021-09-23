//
//  URLSessionClientTests.swift
//  GroceryKitTests
//
//  Created by Bruce on 2021/9/23.
//  Copyright © 2021 Grocery. All rights reserved.
//

import XCTest
@testable import GroceryKit

class URLSessionClientTests: XCTestCase {
    var client: URLSessionClient!
    var e: XCTestExpectation!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.client = URLSessionClient(host: "https://api.cn.ronghub.com")
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.client = nil
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.e = self.expectation(description: "URLSessionClientTests exception")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TokenRequest() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let req = TokenRequest(userId: "44u32jfdsa32498320", name: "hello")
        client.send(req) { response, error in
            if let repo = response {
                print(repo)
            } else {
                XCTAssert(true)
            }
            self.e.fulfill()
        }
        
        self.waitForExpectations(timeout: 30) { (error) in
            if let err = error {
                print(err)
                XCTAssert(false)
            } else {

            }

        }
    }

}
