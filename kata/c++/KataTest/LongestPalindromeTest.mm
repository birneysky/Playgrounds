//
//  LongestPalindromeTest.m
//  KataTest
//
//  Created by birney on 2020/8/17.
//

#import <XCTest/XCTest.h>
#include <string>

#include "LongestPalindrome.hpp"

@interface LongestPalindromeTest : XCTestCase

@end

@implementation LongestPalindromeTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testLongestPalindrome1 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    LongestPalindrome s;
    std::string plain = s.longestPalindrome("babad");
    XCTAssertEqual(plain == "bab" || plain == "aba", true);
}


- (void)testLongestPalindrome2 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    LongestPalindrome s;
    std::string plain = s.longestPalindrome("babadab");
    XCTAssertEqual(plain == "badab", true);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
