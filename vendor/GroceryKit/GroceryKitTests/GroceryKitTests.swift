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
    var hc: HtppClient!
    var e: XCTestExpectation!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        client = URLSessionClient()
        hc = HtppClient()
        e = self.expectation(description: "expectation")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        client = nil
        hc = nil
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
                XCTAssert(false)
                print(err)
            } else {
                
            }
            
        }
    }
    
    func test_fetchToken() {
        let name = "name"
        firstly {
            self.hc.fetchToken(uid: "123", name: name)
        }.then { (token) in
             self.hc.fetchToken(uid: "xfdas", name: "are you ok")
        }.done { token in
            print("2 \(token)")
        }.catch { err in
            print(err)
            XCTAssert(false)
        }
        
        firstly {
            self.hc.fetchToken(uid: "123", name: "456")
        }.then { token in
            //print("3\(token)")
            self.hc.fetchToken(uid: "xfdas", name: "are you ok")
        }.done { token in
            print("4 \(token)")
            self.e.fulfill()
        }.catch { err in
                print(err)
                XCTAssert(false)
        }

        self.waitForExpectations(timeout: 30) { (error) in
            if let err = error {
                XCTAssert(false)
                print(err)
            } else {
                
            }
            
        }
    }
    
    func test_promisekit_mutileline () {
        let name = "name"
        
        let start = CACurrentMediaTime()
        firstly{ () -> Promise<String> in
            print("firstly a")
            return self.hc.fetchToken(uid: "123", name: name)
        }.then { token -> Promise<String> in
            print("then 1 \(token)")
            return self.hc.fetchToken(uid: "xfdas", name: "are you ok")
        }.then { token -> Promise<String> in
            print("then 2 \(token)")
            return self.hc.fetchToken(uid: "xfdasfjdklasjfld", name: "bulabulabula")
        }.then { token -> Promise<String> in
            print("then 3 \(token)")
            return self.hc.fetchToken(uid: "43204802", name: "so what")
        }.done { token in
            print("done 4 \(token)")
        }.catch { err in
            print(err)
            XCTAssert(false)
        }
        
        firstly{ () -> Promise<String> in
            print("firstly b")
            return self.hc.fetchToken(uid: "123", name: name)
        }.then { token -> Promise<String> in
            print("then 5 \(token)")
            return self.hc.fetchToken(uid: "xfdas", name: "are you ok")
        }.then { token -> Promise<String> in
            print("then 6 \(token)")
            return self.hc.fetchToken(uid: "xfdasfjdklasjfld", name: "bulabulabula")
        }.then { token -> Promise<String> in
            print("then 7 \(token)")
            return self.hc.fetchToken(uid: "43204802", name: "so what")
        }.done { token in
            print("done 8 \(token)")
            self.e.fulfill()
        }.catch { err in
            print(err)
            XCTAssert(false)
        }

        self.waitForExpectations(timeout: 30) { (error) in
            if let err = error {
                XCTAssert(false)
                print(err)
            } else {
                let end = CACurrentMediaTime()
                print("duration:\(end-start)")
            }
            
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
