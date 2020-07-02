//
//  DuplicateTest.m
//  KataTest
//
//  Created by birneysky on 2020/7/2.
//

#import <XCTest/XCTest.h>
#include "Duplicate.hpp"

@interface DuplicateTest : XCTestCase

@end

@implementation DuplicateTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    std::vector<int> nums1{2, 3, 1, 0, 2, 5, 3};
    int result = -1;
    duplicate1(nums1, &result);
    XCTAssertEqual(result, 2);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
