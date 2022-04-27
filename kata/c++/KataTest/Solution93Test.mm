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
    
}



@end
