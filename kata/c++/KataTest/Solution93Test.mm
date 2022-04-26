//
//  Solution93Test.m
//  KataTest
//
//  Created by Bruce on 2022/4/20.
//

#import <XCTest/XCTest.h>
#include "Solution93.hpp"
#include "Solution17.hpp"
#include "Solution47.hpp"
#include "KataHelper.hpp"

@interface Solution93Test : XCTestCase

@end

@implementation Solution93Test

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

#pragma mark - Test back track

- (void)testSolution17 {
    Solution17 s;
    vector<string> v = s.letterCombinations("23");
    vector<string> vs {"ad", "ae", "af", "bd", "be",
                       "bf", "cd", "ce", "cf"};
    XCTAssert(v == vs);
    v = s.letterCombinations("234");
    vs = {"adg", "adh", "adi", "aeg", "aeh", "aei", "afg",
          "afh", "afi", "bdg", "bdh", "bdi", "beg", "beh",
          "bei", "bfg", "bfh", "bfi", "cdg", "cdh", "cdi",
          "ceg", "ceh", "cei", "cfg", "cfh", "cfi" };
    XCTAssert(v == vs);
    v = s.letterCombinations("2");
    vs = {"a","b","c"};
    XCTAssert(v == vs);
    
    v = s.letterCombinations("");
    vs = {};
    XCTAssert(v == vs);
}

- (void)testSolution47 {
    Solution47 s;
    vector<int> nums {1, 2, 3};
    vector<vector<int>> result = s.permute(nums);
    vector<vector<int>> tr { {1, 2, 3}, {1, 3, 2}, {2, 1, 3},
                             {2, 3, 1}, {3, 1, 2}, {3, 2, 1}};
    XCTAssert(result == tr);
    nums = {0, 1};
    result = s.permute(nums);
    tr = { {0, 1}, {1, 0} };
    XCTAssert(result == tr);
    
    nums = {1};
    result = s.permute(nums);
    tr = { {1} };
    XCTAssert(result == tr);
}

- (void)testSolution93 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    Solution93 s;
    vector<string> v = s.restoreIpAddresses("1111");

    XCTAssert(v.size() == 1);
    std::cout << v << std::endl;
    
    
    v = s.restoreIpAddresses("101023");
    XCTAssert(v.size() == 5);
    std::cout << v << std::endl;
    
    v = s.restoreIpAddresses("25525511135");
    XCTAssert(v.size() == 2);
    std::cout << v << std::endl;
    
}



@end
