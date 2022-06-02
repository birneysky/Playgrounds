//
//  EmptyTest.m
//  KataTest
//
//  Created by birneysky on 2020/7/2.
//

#import <XCTest/XCTest.h>
#include <iostream>

#include "Playground.hpp"


@interface PlaygroundTest : XCTestCase

@end

@implementation PlaygroundTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


- (void)testChordCount {
    int result = ChordCount(12);
    XCTAssertEqual(result, 10);
    
    result = ChordCount(1000);
    XCTAssertEqual(result, 1986);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
