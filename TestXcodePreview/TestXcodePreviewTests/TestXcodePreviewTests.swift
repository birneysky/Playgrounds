//
//  TestXcodePreviewTests.swift
//  TestXcodePreviewTests
//
//  Created by Bruce on 2024/1/5.
//

import XCTest
import UIKit
@testable import TestXcodePreview

//extension JSONDecoder {
//    func decode<T>(_ dictionary: [String: Any], to type: T.Type) -> T? {
//        let mirror = Mirror(reflecting: type.init())
//        var object = type.init()
//
//        for child in mirror.children {
//            guard let key = child.label else { continue }
//            if let value = dictionary[key], let decodedValue = value as? T.Value {
//                object[key] = decodedValue
//            }
//        }
//    }
//}

final class TestXcodePreviewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        XCTAssert(UIColor.clear == UIColor.clear)
        let a = KTVRankItemViewController.controller()
        XCTAssert(a.isKind(of: KTVRankItemViewController.self))
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    
    
    func testMirror() {
        struct Point {
            let x: Int, y: Int
        }

        let p = Point(x: 21, y: 30)
        let reflect = String(reflecting: p)
        print(p)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
