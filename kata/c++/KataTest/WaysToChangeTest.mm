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

- (void)testShowWaysToChange5 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    WaysToChange s;
    //XCTAssertEqual(s.waysToChange(5), 2);
    s.showWaysToChange(5);
    
    //XCTAssertEqual(, 9);
//    XCTAssertEqual(s.waysToChange1(10), 4);
//    XCTAssertEqual(s.waysToChange1(15), 9);
}


- (void)testShowWaysToChange6 {
    WaysToChange s;
     s.showWaysToChange(6);
}

- (void)testShowWaysToChange7 {
    WaysToChange s;
     s.showWaysToChange(7);
}

- (void)testShowWaysToChange10 {
    WaysToChange s;
     s.showWaysToChange(10);
}

- (void)testShowWaysToChange15 {
    WaysToChange s;
     s.showWaysToChange(15);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
