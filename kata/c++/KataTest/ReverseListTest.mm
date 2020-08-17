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

- (void)testReverseList1 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    std::vector<int> nums{1, 2, 4, 5, 6, 7, 9};
    ListNode* list = new ListNode(nums);
    std::cout << list << std::endl;
    ListNode* head = ReverseList(list);
    std::cout << head;
    for (size_t i = nums.size() - 1; i >= 0 && head != nullptr; i --) {
         XCTAssertEqual(head->val, nums[i]);
         head = head->next;
    }
}

/// 空链表
- (void)testReverseList2 {
    ListNode* head = ReverseList(nullptr);
    XCTAssertEqual(head, nullptr);
}

/// 只有一个元素
- (void)testReverseList3 {
    ListNode* list = new ListNode(3);
    std::cout << list << std::endl;
    ListNode* head = ReverseList(list);
    std::cout << head;
    XCTAssertEqual(head->val, 3);
}

/// 2 个元素
- (void)testReverseList4 {
    std::vector<int> nums {2, 5};
    ListNode* list = new ListNode(nums);
    std::cout << list << std::endl;
    ListNode* head = ReverseList(list);
    std::cout << head;
    for (size_t i = nums.size() - 1; i >= 0 && head != nullptr; i --) {
        XCTAssertEqual(head->val, nums[i]);
        head = head->next;
    }
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
