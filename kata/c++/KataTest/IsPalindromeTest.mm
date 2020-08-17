//
//  IsPalindromeTest.m
//  KataTest
//
//  Created by birneysky on 2020/8/18.
//

#import <XCTest/XCTest.h>
#include <string>

#include "IsPalindrome.hpp"

@interface IsPalindromeTest : XCTestCase

@end

@implementation IsPalindromeTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testIsPalindrome1 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    std::string s = "amanaplanacanalpanama";
    IsPalindrome sol;
    XCTAssertEqual(sol.isPalindrome(s), true);
}

- (void)testIsPalindrome2 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    std::string s = "a";
    IsPalindrome sol;
    XCTAssertEqual(sol.isPalindrome(s), true);
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
