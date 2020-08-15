//
//  LengthOfLongestSubstring.m
//  KataTest
//
//  Created by birneysky on 2020/8/16.
//

#import <XCTest/XCTest.h>
#include <string>

#import "LengthOfLongestSubstring.hpp"

@interface LengthOfLongestSubstring : XCTestCase

@end

@implementation LengthOfLongestSubstring

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

/// 多个重复长度的连续子串
- (void)testLengthOfLongestSubstring1 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    std::string s = "abcabcbb";
    XCTAssertEqual(lengthOfLongestSubstring(s), 3);
}

/// 全部重复的子串
- (void)testLengthOfLongestSubstring2 {
    std::string s = "cccccccccccccccc";
    XCTAssertEqual(lengthOfLongestSubstring(s), 1);
}

/// 全部不重复子串
- (void)testLengthOfLongestSubstring3 {
    std::string s = "abcdefghijklmn";
    XCTAssertEqual(lengthOfLongestSubstring(s), 14);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
