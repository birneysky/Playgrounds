//
//  MergeTwoListsTest.m
//  KataTest
//
//  Created by birneysky on 2020/7/2.
//

#import <XCTest/XCTest.h>
#import "MergeTwoList.hpp"

@interface MergeTwoListsTest : XCTestCase

@end

@implementation MergeTwoListsTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    std::vector<int> nums1{1, 2, 4};
    ListNode* l1 = new ListNode(nums1);
    std::cout << l1;

    std::vector<int> nums2{1, 3, 4};
    ListNode* l2 = new ListNode(nums2);
    std::cout << l2;

    ListNode* head = MergeTwoLists(l1, l2);
    std::cout << head;
    delete l1;
    delete l2;
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
