//
//  CombinationTest.m
//  KataTest
//
//  Created by birney on 2020/9/8.
//

#import <XCTest/XCTest.h>
#include "Combination.hpp"
#include "KataHelper.hpp"

@interface CombinationTest : XCTestCase

@end

@implementation CombinationTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    Combination c;
    auto result = c.combine(10,3);
    std::cout << result << std::endl;
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
