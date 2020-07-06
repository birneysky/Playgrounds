//
//  ReplaceBlankTest.m
//  KataTest
//
//  Created by birneysky on 2020/7/2.
//

#import <XCTest/XCTest.h>
#include "ReplaceBlank.hpp"
#include <iostream>

@interface ReplaceBlankTest : XCTestCase

@end

@implementation ReplaceBlankTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    char string[100] = "we are happy";
    ReplaceBlank(string, 100);
    XCTAssertTrue(string, "we%20are%20happy");
    std::cout << string << std::endl;
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
