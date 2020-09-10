//
//  SimplifyPathTest.m
//  KataTest
//
//  Created by birney on 2020/9/8.
//

#import <XCTest/XCTest.h>
#include <iostream>

#include "SimplifyPath.hpp"

@interface SimplifyPathTest : XCTestCase

@end

@implementation SimplifyPathTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    SimplifyPath s;
    std::string result = s.simplifyPath("/home/");
    XCTAssertEqual(result, "/home");
    std::cout << result << std::endl;
}

- (void)testExample2 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    SimplifyPath s;
    std::string result = s.simplifyPath("/a/./b/../../c/");
    XCTAssertEqual(result, "/c");
    std::cout << result << std::endl;
}


- (void)testExample3 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    SimplifyPath s;
    std::string result = s.simplifyPath("/a//b////c/d//././/..");
    XCTAssertEqual(result, "/a/b/c");
    std::cout << result << std::endl;
}

- (void)testExample4 {
    SimplifyPath s;
    std::string result = s.simplifyPath("/home//foo/");
    XCTAssertEqual(result, "/home/foo");
    std::cout << result << std::endl;
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
