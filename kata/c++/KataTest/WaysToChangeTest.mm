//
//  WaysToChangeTest.m
//  KataTest
//
//  Created by birney on 2020/8/18.
//

#import <XCTest/XCTest.h>

#include "WaysToChange.hpp"

@interface WaysToChangeTest : XCTestCase

@end

@implementation WaysToChangeTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    WaysToChange s;
    //XCTAssertEqual(s.waysToChange(5), 2);
    XCTAssertEqual(s.waysToChange(10), 4);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
