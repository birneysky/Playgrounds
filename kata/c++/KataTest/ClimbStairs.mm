//
//  ClimbStairs.m
//  KataTest
//
//  Created by birneysky on 2020/8/16.
//

#import <XCTest/XCTest.h>
#include <iostream>

#include "ClimbStairs.hpp"

@interface ClimbStairs : XCTestCase

@end

@implementation ClimbStairs

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testclimbStairs1 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertEqual(climbStairs(1), 1);
    XCTAssertEqual(climbStairs(2), 2);
    XCTAssertEqual(climbStairs(3), 3);
    
    XCTAssertEqual(climbStairs(20), 10946);
    XCTAssertEqual(climbStairs(30), 1346269);
    XCTAssertEqual(climbStairs(45), 1836311903);
    
}

- (void)testclimbStairs2 {
    Solution s;
    XCTAssertEqual(s.climbStairs2(1), 1);
    XCTAssertEqual(s.climbStairs2(2), 2);
    XCTAssertEqual(s.climbStairs2(3), 3);
    
    XCTAssertEqual(s.climbStairs2(20), 10946);
    XCTAssertEqual(s.climbStairs2(30), 1346269);
    XCTAssertEqual(s.climbStairs2(45), 1836311903);
 
}

- (void)testclimbStairs3 {
    Solution s;
    XCTAssertEqual(s.climbStairs2(75), 1412467027);
    XCTAssertEqual(s.climbStairs2(2), 2);
}

- (void)testclimbStairs3_1 {
    XCTAssertEqual(climbStairs3(1), 1);
    XCTAssertEqual(climbStairs3(2), 2);
    XCTAssertEqual(climbStairs3(3), 3);
    
    XCTAssertEqual(climbStairs3(20), 10946);
    XCTAssertEqual(climbStairs3(30), 1346269);
    XCTAssertEqual(climbStairs3(45), 1836311903);
    XCTAssertEqual(climbStairs3(75), 1412467027);
}

- (void)testPerformanceclimbStairs {
    // This is an example of a performance test case.
    [self measureBlock:^{
        for (int i = 0; i < 40; i++) {
            climbStairs(i);
        }
        // Put the code you want to measure the time of here.
    }];
}

- (void)testPerformanceclimbStairs2 {
    // This is an example of a performance test case.

    [self measureBlock:^{
        Solution s;
        for (int i = 0; i < 75; i++) {
            s.climbStairs2(i);
        }
        // Put the code you want to measure the time of here.
    }];
}


- (void)testPerformanceclimbStairs3 {
    // This is an example of a performance test case.

    [self measureBlock:^{
        for (int i = 0; i < 75; i++) {
            climbStairs3(i);
        }
        // Put the code you want to measure the time of here.
    }];
}

@end
