//
//  Solution93Test.m
//  KataTest
//
//  Created by Bruce on 2022/4/20.
//

#import <XCTest/XCTest.h>
#include "Solution93.hpp"
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

- (void)testExample {
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

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
