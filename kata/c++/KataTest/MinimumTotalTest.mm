//
//  MinimumTotalTest.m
//  KataTest
//
//  Created by birneysky on 2020/8/16.
//

#import <XCTest/XCTest.h>
#include <vector>
#include <iostream>

#include "MinimumTotal.hpp"
#include "MinimumTotalTestData.hpp"

@interface MinimumTotalTest : XCTestCase

@end

@implementation MinimumTotalTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

/// 全部为正整数
- (void)testMinimumTotal1 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    std::vector<std::vector<int>> triangle{
        {2},
        {3,4},
        {6,5,7},
        {4,1,8,3}
    };
    
    MinimumTotal s;
    XCTAssertEqual(s.minimumTotal(triangle), 11);
    MinimumTotal2 s2;
    XCTAssertEqual(s2.minimumTotal(triangle), 11);
}

/// 含有负数
- (void)testMinimumTotal2 {
    std::vector<std::vector<int>> triangle {
        {-1},
        {2,3},
        {1,-1,-3}
    };
    MinimumTotal s;
    XCTAssertEqual(s.minimumTotal(triangle), -1);
    MinimumTotal2 s2;
    XCTAssertEqual(s2.minimumTotal(triangle), -1);
}

- (void)testMinimumTotalForBigTriangle {
    MinimumTotal2 s;
    XCTAssertEqual(s.minimumTotal(bigTriangle), -8717);
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
