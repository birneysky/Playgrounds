//
//  JsonDecodeTests.swift
//  GroceryKitTests
//
//  Created by Bruce on 2021/9/23.
//  Copyright © 2021 Grocery. All rights reserved.
//

import XCTest
@testable import GroceryKit


struct Person: Decodable {
    var name: String
    var age: Int
    var hobby: [String]
    var location: Location
    
    struct Location: Decodable {
        var country: String
        var city: String
    }
}

class JsonDecodeTests: XCTestCase {
    var bundle: Bundle!
    
    override func setUp() {
        self.bundle = Bundle(for: type(of: self))
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJsonDecode1() throws {
        let json = """
        {
            "name": "SeekingMini",
            "age": 21,
            "hobby": ["Swimming","coding"],
            "location": {
                "country": "China",
                "city": "Suzhou"
            }
        }
        """
        
        guard let jsonData = json.data(using: .utf8) else {
            XCTAssertTrue(false)
            return
        }
        guard let person = try? JSONDecoder().decode(Person.self, from: jsonData) else {
            XCTAssertTrue(false)
            return
        }
        
        XCTAssertEqual(person.name, "SeekingMini")
    }
    
    func testJsonDecodeStockItem() throws {
        guard let path =  bundle.path(forResource: "StockItem", ofType: "geojson") else {
            XCTAssertTrue(false)
            return;
        }
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else {
            XCTAssertTrue(false)
            return;
        }
        
        guard let stock = try? JSONDecoder().decode(StockItem.self, from: data) else {
            XCTAssertTrue(false)
            return
        }
        XCTAssertEqual(stock.name, "中国船舶")
    }
    
    
    func testJsonDecodeTopAmountData() throws {
        guard let path =  bundle.path(forResource: "StockItemLists", ofType: "geojson") else {
            XCTAssertTrue(false)
            return;
        }
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else {
            XCTAssertTrue(false)
            return;
        }
        do {
          let top = try JSONDecoder().decode(TopAmountData.self, from: data)
            XCTAssertEqual(top.count, 3)
        } catch {
            XCTAssertTrue(false)
            print("Unexpected error: \(error).")
        }
    }
    
    func testJsonDecodeTopAmountResponse() {
        guard let path =  bundle.path(forResource: "TopStockLists", ofType: "geojson") else {
            XCTAssertTrue(false)
            return;
        }
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else {
            XCTAssertTrue(false)
            return;
        }
        do {
          let response = try JSONDecoder().decode(TopAmountResponse.self, from: data)
            XCTAssertEqual(response.data.count, 4574)
            XCTAssertEqual(response.error_code, 0);
            XCTAssertEqual(response.data.list.count, 30)
        } catch {
            XCTAssertTrue(false)
            print("Unexpected error: \(error).")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
