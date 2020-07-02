//
//  BinarySearchTest.m
//  BinarySearchTest
//
//  Created by birneysky on 2020/7/2.
//

#import <XCTest/XCTest.h>
#import "BinarySearch.hpp"

@interface BinarySearchTest : XCTestCase

@end

@implementation BinarySearchTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    std::vector<int> nums1{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    assert(binarySearch(nums1, 3) == 3);
    std::vector<int> nums2{10, 30, 45, 67, 89, 90, 91, 92, 93, 94};
    assert(binarySearch(nums2, 30) == 1);
    assert(binarySearch(nums1, 11) == -1);


}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        std::vector<int> nums2{10, 30, 45, 67, 89, 90, 91, 92, 93, 94};
        assert(binarySearch(nums2, 30) == 1);
    }];
}

@end
