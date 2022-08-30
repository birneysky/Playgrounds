//
//  Solution93Test.m
//  KataTest
//
//  Created by Bruce on 2022/4/20.
//

#import <XCTest/XCTest.h>
#include "KataHelper.hpp"

#include "Solution93.hpp"
#include "Solution17.hpp"
#include "Solution47.hpp"
#include "Solution77.hpp"
#include "Solution78.hpp"
#include "Solution39.hpp"
#include "Solution79.hpp"
#include "Solution90.hpp"
#include "Solution40.hpp"
#include "Solution37.hpp"
#include "Solution51.hpp"
#include "Solution22.hpp"
#include "Solution322.hpp"
#include "Solution70.hpp"
#include "Solution121.hpp"
#include "Solution300.hpp"
#include "Solution120.hpp"
#include "Solution64.hpp"
#include "SolutionCoinLcci.hpp"

@interface SolutionTest : XCTestCase

@end

@implementation SolutionTest

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
    vector<string> output = s.letterCombinations("23");
    vector<string> td {"ad", "ae", "af", "bd", "be",
                       "bf", "cd", "ce", "cf"};
    XCTAssert(output == td);
    tlog("23", output);
    output = s.letterCombinations("234");
    td = {"adg", "adh", "adi", "aeg", "aeh", "aei", "afg",
          "afh", "afi", "bdg", "bdh", "bdi", "beg", "beh",
          "bei", "bfg", "bfh", "bfi", "cdg", "cdh", "cdi",
          "ceg", "ceh", "cei", "cfg", "cfh", "cfi" };
    XCTAssert(output == td);
    tlog("234", output);
    output = s.letterCombinations("2");
    td = {"a","b","c"};
    XCTAssert(output == td);
    tlog("2", output);
    output = s.letterCombinations("");
    td = {};
    XCTAssert(output == td);
    tlog("", output);
}

- (void)testSolution47 {
    Solution47 s;
    vector<int> input {1, 2, 3};
    vector<vector<int>> output = s.permute(input);
    vector<vector<int>> td { {1, 2, 3}, {1, 3, 2}, {2, 1, 3},
                             {2, 3, 1}, {3, 1, 2}, {3, 2, 1}};
    XCTAssert(output == td);
    tlog(input, output);
    input = {0, 1};
    output = s.permute(input);
    td = { {0, 1}, {1, 0} };
    XCTAssert(output == td);
    tlog(input, output);
    input = {1};
    output = s.permute(input);
    td = {{1}};
    XCTAssert(output == td);
    tlog(input, output);
}

- (void)testSolution77 {
    Solution77 s;
    vector<vector<int>> output = s.combine(4, 2);
    vector<vector<int>> td { {1, 2}, {1, 3}, {1, 4},
                             {2, 3}, {2, 4}, {3, 4}};
    XCTAssert(output == td);
    tlog("n = 4, k = 2", output);
    
    
    output = s.combine(1, 1);
    td =  { { 1 } };
    XCTAssert(output == td);
    tlog("n = 1, k = 1", output);
}

- (void)testSolution78 {
    Solution78 s;
    vector<int> input {1, 2, 3};
    vector<vector<int>> output = s.subsets(input);
    vector<vector<int>> td { { }, { 1 }, {1, 2}, {1, 2, 3}, {1, 3}, { 2 }, {2, 3}, {3}};
    XCTAssert(output == td);
    tlog(input, output);
    
    input = { 0 };
    td = { { }, { 0 }};
    output = s.subsets(input);
    XCTAssert(output == td);
    tlog(input, output);
}

- (void)testSolution93 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    Solution93 s;
    vector<string> output = s.restoreIpAddresses("1111");
    vector<string> td {  "1.1.1.1"  };
    XCTAssert(output == td);
    tlog("111", output);
    
    
    output = s.restoreIpAddresses("101023");
    td = { "1.0.10.23","1.0.102.3","10.1.0.23","10.10.2.3","101.0.2.3" };
    XCTAssert(output == td);
    tlog("101023", output);

    output = s.restoreIpAddresses("25525511135");
    td = {"255.255.11.135", "255.255.111.35"};
    XCTAssert(output == td);
    tlog("25525511135", output);
    
    output = s.restoreIpAddresses("111");
    td = {};
    XCTAssert(output == td);
    tlog("111", output);
    
}

- (void)testSolution39 {
    Solution39 s;
    vector<int> input {2, 3, 6, 7};
    vector<vector<int>> output =  s.combinationSum(input, 7);
    vector<vector<int>> ts { {2, 2, 3}, { 7 }};
    XCTAssert(output == ts);
    tlog("[2, 3, 6, 7], 7", output);
    
    input = {2,3,5};
    ts =  { {2, 2, 2, 2}, {2, 3, 3}, {3, 5} };
    output = s.combinationSum(input, 8);
    XCTAssert(output == ts);
    tlog("[2, 3, 5], 8", output);
    
    input = { 2 };
    ts = {};
    output = s.combinationSum(input, 1);
    XCTAssert(output == ts);
    tlog("[2], 1", output);
}

- (void)testSolution79 {
    Solution79 s;
}

- (void)testSolution90 {
    Solution90 s;
}

- (void)testSolution40 {
    Solution40 s;
}

- (void)testSolution37 {
    Solution37 s;
}

- (void)testSolution51 {
    Solution51 s;
}

- (void)testSolution22 {
    Solution22 s;
}

#pragma mark - dynamic
- (void)testSolution322 {
    Solution322 s;
    vector<int> coins {1, 2, 5};
    XCTAssert(s.coinChange(coins, 11) == -1);
}

- (void)testSolution70 {
    Solution70 s;
    XCTAssert(s.climbStairs(10) == -1);
}

- (void)testSolution121 {
    Solution121 s;
    vector<int> a {1, 2, 5};
    XCTAssert(s.maxProfit(a) == -1);
}

- (void)testSolution300 {
    Solution300 s;
    vector<int> num {1, 2, 5};
    XCTAssert(s.lengthOfLIS(num) == -1);
}

- (void)testSolution120 {
    Solution120 s;
}

- (void)testSolution64 {
    Solution64 s;
}

- (void)testSolutionCoinLcci {
    SolutionCoinLcci s;
}

@end
