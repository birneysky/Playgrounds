//
//  MinPathSum.m
//  KataTest
//
//  Created by birneysky on 2020/8/16.
//

#import <XCTest/XCTest.h>
#include <vector>
#include <iostream>
#include "MinPathSum.hpp"
#include "MinPathSumTestData.hpp"

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
    XCTAssertEqual(s.minPathSum2(matrix), 7);
    XCTAssertEqual(s.minPathSum3(matrix), 7);
}

- (void)testMinPathSum2 {
    std::vector<std::vector<int> > matrix {
        {1,2,5},
        {3,2,1}
    };
    
    MinPathSum s;
    XCTAssertEqual(s.minPathSum2(matrix), 6);
    XCTAssertEqual(s.minPathSum3(matrix), 6);
}


- (void)testMinPathSum3 {
    MinPathSum s;
    XCTAssertEqual(s.minPathSum2(grid), 83);
    XCTAssertEqual(s.minPathSum3(grid), 83);
}


- (void)testPerformanceMinPathSum2 {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        MinPathSum s;
        std::vector<std::vector<std::vector<int>>> matrixs{
            {
                { 1, 3, 1 },
                { 1, 5, 1 },
                { 4, 2, 1 }
            },
            {
                {1,2,5},
                {3,2,1}
            },
            grid
        };
        for (int i = 0; i < matrixs.size(); i++) {
            s.minPathSum2(matrixs[i]);
        }
    }];
}


- (void)testPerformanceMinPathSum3 {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        MinPathSum s;
        std::vector<std::vector<std::vector<int>>> matrixs{
            {
                { 1, 3, 1 },
                { 1, 5, 1 },
                { 4, 2, 1 }
            },
            {
                {1,2,5},
                {3,2,1}
            },
            grid
        };
        for (int i = 0; i < matrixs.size(); i++) {
            s.minPathSum3(matrixs[i]);
        }
    }];
}

@end
