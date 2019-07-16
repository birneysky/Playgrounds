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
    var e: XCTestExpectation!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        client = URLSessionClient()
        e = self.expectation(description: "expectation")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        client = nil
    }

    func test_TokenRequest() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let req = TokenRequest(userId: "44u32jfdsa32498320", name: "hello")
        client.send(req) { (token) in
                print(token)
                self.e.fulfill()
        }
        self.waitForExpectations(timeout: 30) { (error) in
            print(error)
        }
    }
    
    func printPointer<T>(address p: UnsafeRawPointer, as type: T.Type) {
        let value = p.load(fromByteOffset: 1,as: type)
        Swift.print(value)
    }
    
    func test_UnsafeRawPointer() {
        let a: [UInt8] = [0,1,2,3,4,5]
        let pointer = UnsafeRawPointer(a)
        printPointer(address: pointer, as: UInt8.self)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
