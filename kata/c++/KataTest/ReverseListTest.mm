//
//  ReverseListTest.m
//  KataTest
//
//  Created by birneysky on 2020/7/2.
//

#import <XCTest/XCTest.h>
#import "ReverseList.hpp"

@interface ReverseListTest : XCTestCase

@end

@implementation ReverseListTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    std::vector<int> nums1{1, 2, 4, 5, 6, 7, 9};
    ListNode* l1 = new ListNode(nums1);
    std::cout << l1 << std::endl;
    ListNode* l2 = ReverseList(l1);
    std::cout << l2;
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
