//
//  FindMedianSortedArraysTest.m
//  KataTest
//
//  Created by birney on 2020/9/10.
//

#import <XCTest/XCTest.h>
#include "FindMedianSortedArrays.hpp"

@interface FindMedianSortedArraysTest : XCTestCase

@end

@implementation FindMedianSortedArraysTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample1 {
    
    FindMedianSortedArrays s;
    std::vector<int> nums1 {1, 3};
    std::vector<int> nums2 = { 2 };
    double result = s.findMedianSortedArrays(nums1, nums2);
    XCTAssertEqual(result, 2);
}


- (void)testExample2 {
    
    FindMedianSortedArrays s;
    std::vector<int> nums1 {1, 2};
    std::vector<int> nums2 = {3, 4};
    double result = s.findMedianSortedArrays(nums1, nums2);
    XCTAssertEqual(result, 2.5);
}

- (void)testExample3 {
    
    FindMedianSortedArrays s;
    std::vector<int> nums1 {1, 2,3, 4};
    std::vector<int> nums2 = {5, 6, 7, 8};
    double result = s.findMedianSortedArrays(nums1, nums2);
    XCTAssertEqual(result, 4.5);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
