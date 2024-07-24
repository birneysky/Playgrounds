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
   
    
    func testFetchSubString1() throws {
        let text = "#somestring0##somestring#somestring1"
        guard let a = text.subString(pattern: "#[^#]*#+([^#]*)#*", in: 15) else { fatalError() }
        XCTAssert(a == "somestring")
        
        guard let a1 = text.subString(pattern: "#[^#]*#+([^#]*)#*", in: 14) else { fatalError() }
        XCTAssert(a1 == "somestring")
        
        
        XCTAssert(text.subString(pattern: "#[^#]*#+([^#]*)#*", in: 13) == nil)
        
        guard let a3 = text.subString(pattern: "#[^#]*#+([^#]*)#*", in: 23) else { fatalError() }
        XCTAssert(a3 == "somestring")
        
        XCTAssert(text.subString(pattern: "#[^#]*#+([^#]*)#*", in: 24) == nil)
        XCTAssert(text.subString(pattern: "#[^#]*#+([^#]*)#*", in: 25) == nil)
    }
    
    /**
     •  [^#]*：匹配零个或多个非 # 字符。

     •  #+：匹配一个或多个 # 字符。

     •  ([^#]*)：捕获零个或多个非 # 字符。

     •  #*：匹配零个或多个 # 字符。
     
     */
    func testFetchSubString2() throws {
        var text = "#ab##def#cdg"
        guard let a = text.subString(pattern: "#[^#]*#+([^#]*)#*", in: 5) else { fatalError() }
        XCTAssert(a == "def")
        
        guard let a1 = text.subString(pattern: "#[^#]*#+([^#]*)#*", in: 6) else { fatalError() }
        XCTAssert(a1 == "def")
        
        
        XCTAssert(text.subString(pattern: "#[^#]*#+([^#]*)#*", in: 8) == nil)
        
        
        text = "#ab###def#cdg"
        guard let a2 = text.subString(pattern: "#[^#]*#+([^#]*)#*", in: 6) else { fatalError() }
        XCTAssert(a2 == "def")
        
        text = "#ab#def#cdg"
        guard let a3 = text.subString(pattern: "#[^#]*#+([^#]*)#*", in: 4) else { fatalError() }
        XCTAssert(a3 == "def")
        
        /// #{2,}表示至少有2个 #
        XCTAssert(text.subString(pattern: "#[^#]*#{2,}([^#]*)#*", in: 4) == nil)
        
        
        text = "#ab##def#cdg"
        guard let a4 = text.subString(pattern: "#[^#]*#{2,}([^#]*)#*", in: 5) else { fatalError() }
        XCTAssert(a4 == "def")
        
        
        text = "#ab###def#cdg"
        guard let a5 = text.subString(pattern: "#[^#]*#{2,}([^#]*)#*", in: 6) else { fatalError() }
        XCTAssert(a5 == "def")
        
        
        text = "#ab###我知道你是谁#cdg"
        guard let a6 = text.subString(pattern: "#[^#]*#{2,}([^#]*)#*", in: 6) else { fatalError() }
        XCTAssert(a6 == "我知道你是谁")
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
