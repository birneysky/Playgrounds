//
//  FindMatrixTest.m
//  KataTest
//
//  Created by birneysky on 2020/7/2.
//

#import <XCTest/XCTest.h>
#import "FindMatrix.hpp"

@interface FindMatrixTest : XCTestCase

@end

@implementation FindMatrixTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

/// 要查找的数在数组中
- (void)testFind1 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    int matrix[4][4] = {{1, 2, 8, 9}, {2, 4, 9, 12}, {4, 7, 10, 13}, {6, 8, 11, 15}};
    bool result = Find((int*)matrix, 4, 4, 7);
    XCTAssertEqual(result, true);
}

/// 要查找的数不在数组中
- (void)testFind2 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    int matrix[4][4] = {{1, 2, 8, 9}, {2, 4, 9, 12}, {4, 7, 10, 13}, {6, 8, 11, 15}};
    bool result = Find((int*)matrix, 4, 4, 5);
    XCTAssertEqual(result, false);
}

/// 要查找的数是数组中最小的数字
- (void)testFind3 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    int matrix[4][4] = {{1, 2, 8, 9}, {2, 4, 9, 12}, {4, 7, 10, 13}, {6, 8, 11, 15}};
    bool result = Find((int*)matrix, 4, 4, 1);
    XCTAssertEqual(result, true);
}

/// 要查找的数是数组中最大的数字
- (void)testFind4 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    int matrix[4][4] = {{1, 2, 8, 9}, {2, 4, 9, 12}, {4, 7, 10, 13}, {6, 8, 11, 15}};
    bool result = Find((int*)matrix, 4, 4, 15);
    XCTAssertEqual(result, true);
}

///  要查找的数比数组中最小的数字还小
- (void)testFind5 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    int matrix[4][4] = {{1, 2, 8, 9}, {2, 4, 9, 12}, {4, 7, 10, 13}, {6, 8, 11, 15}};
    bool result = Find((int*)matrix, 4, 4, 0);
    XCTAssertEqual(result, false);
}

/// 要查找的数比数组中最大的数字还大
- (void)testFind6 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    int matrix[4][4] = {{1, 2, 8, 9}, {2, 4, 9, 12}, {4, 7, 10, 13}, {6, 8, 11, 15}};
    bool result = Find((int*)matrix, 4, 4, 19);
    XCTAssertEqual(result, false);
}

/// 输入空指针
- (void)testFind7 {
    bool result = Find(nullptr, 4, 4, 19);
    XCTAssertEqual(result, false);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
