//
//  MinPathSum.m
//  KataTest
//
//  Created by birneysky on 2020/8/16.
//

#import <XCTest/XCTest.h>

#include "MinPathSum.hpp"

@interface MinPathSumTest : XCTestCase

@end

@implementation MinPathSumTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testMinPathSum1 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    std::vector<std::vector<int> > matrix {
        { 1, 3, 1 },
        { 1, 5, 1 },
        { 4, 2, 1 }
    };
    
    MinPathSum s;
    XCTAssertEqual(s.minPathSum(matrix), 7);
}

- (void)testMinPathSum2 {
    std::vector<std::vector<int> > matrix {
        {1,2,5},
        {3,2,1}
    };
    
    MinPathSum s;
    XCTAssertEqual(s.minPathSum(matrix), 6);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
