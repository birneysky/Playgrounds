//
//  PrintListReverseinglyTest.m
//  KataTest
//
//  Created by birneysky on 2020/7/2.
//

#import <XCTest/XCTest.h>
#include "PrintListReverseingly.hpp"

@interface PrintListReverseinglyTest : XCTestCase

@end

@implementation PrintListReverseinglyTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testPrintList {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    std::vector<int> nums{1, 2, 4, 5, 6, 7, 9};
    ListNode node(nums);
    PrintList(&node);
    PrintList(nullptr);
}

- (void)testPrintListReverseingly {
    std::vector<int> nums{1, 2, 4, 5, 6, 7, 9};
    ListNode node(nums);
    PrintListReverseingly(&node);
    std::cout << std::endl;
}

- (void)testPrintListReverseingly2 {
    std::vector<int> nums{1, 2, 4, 5, 6, 7, 9};
    ListNode node(nums);
    PrintListReverseingly2(&node);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
