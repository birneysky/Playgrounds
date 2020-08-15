//
//  MaxProfit.m
//  KataTest
//
//  Created by birneysky on 2020/8/15.
//

#import <XCTest/XCTest.h>
#include <vector>

#include "MaxProfit.hpp"

@interface MaxProfit : XCTestCase

@end

@implementation MaxProfit

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

/// 最小值和最大值均在左侧, 先降后升在降再升再降
- (void)testMaxProfit1 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    std::vector<int> nums { 7, 1, 5, 3, 6, 4 };
    XCTAssertEqual(maxProfit(nums), 5);
    XCTAssertEqual(maxProfit1(nums), 5);
}

/// 降序排列
- (void)testMaxProfit2 {
    std::vector<int> nums { 7, 6, 4, 3, 1 };
    XCTAssertEqual(maxProfit(nums), 0);
    XCTAssertEqual(maxProfit1(nums), 0);
}

/// 只有 2 个数据升序排列
- (void)testMaxProfit3 {
    std::vector<int> nums { 1, 2 };
    XCTAssertEqual(maxProfit(nums), 1);
    XCTAssertEqual(maxProfit1(nums), 1);
}

/// [2,1,4]  先降后升
- (void)testMaxProfit4 {
    std::vector<int> nums { 2, 1, 4 };
    XCTAssertEqual(maxProfit(nums), 3);
    XCTAssertEqual(maxProfit1(nums), 3);
}

/// 数据完全相同
- (void)testMaxProfit5 {
    std::vector<int> nums { 8, 8, 8, 8, 8, 8 };
    XCTAssertEqual(maxProfit(nums), 0);
    XCTAssertEqual(maxProfit1(nums), 0);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
