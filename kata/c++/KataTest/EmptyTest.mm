//
//  EmptyTest.m
//  KataTest
//
//  Created by birneysky on 2020/7/2.
//

#import <XCTest/XCTest.h>
#include <iostream>

#import "Empty.hpp"

@interface EmptyTest : XCTestCase

@end

@implementation EmptyTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    Empty t;
    /// c++ 空对象内存中占用一个字节
    std::cout << sizeof(class Empty) << std::endl;
    std::cout << sizeof(t) << std::endl;
    XCTAssertEqual(sizeof(t), 1);
    
    /// c++ 带有虚函数，类中添加虚函数表指针
    std::cout << sizeof(class VEmpty) << std::endl;
    XCTAssertEqual(sizeof(class VEmpty), 8);
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
