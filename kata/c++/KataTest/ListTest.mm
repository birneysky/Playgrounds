//
//  ListTest.m
//  KataTest
//
//  Created by birney on 2020/9/15.
//

#import <XCTest/XCTest.h>
#include "KataHelper.hpp"

@interface ListTest : XCTestCase

@end

@implementation ListTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    std::list<int> list1;
    for (int i = 1; i < 10; i += 2) {
        list1.push_back(i);
    }
    
    std::list<int> list2;
    for (int i = 2; i <= 10; i += 2) {
        list2.push_back(i);
    }
    
    std::cout << list1 << std::endl;
    std::cout << list2 << std::endl;
}

- (void)testSplice1 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    std::list<int> list1;
    for (int i = 1; i < 10; i += 2) {
        list1.push_back(i);
    }
    
    std::list<int> list2;
    for (int i = 2; i <= 10; i += 2) {
        list2.push_back(i);
    }
    
    std::cout << list1 << std::endl;
    std::cout << list2 << std::endl;
    
    auto it = list1.begin();
    list1.splice(it, list2);
    
    std::cout << list1 << std::endl;
    std::cout << list2 << std::endl;
}


- (void)testSplice2 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    std::list<int> list1;
    for (int i = 1; i < 10; i += 2) {
        list1.push_back(i);
    }
    
    std::list<int> list2;
    for (int i = 2; i <= 10; i += 2) {
        list2.push_back(i);
    }
    
    std::cout << list1 << std::endl;
    std::cout << list2 << std::endl;
    
    auto it = list1.begin();
    it ++;
    it ++;
    list1.splice(it, list2);
    
    std::cout << list1 << std::endl;
    std::cout << list2 << std::endl;
}

- (void)testSplice3 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    std::list<int> list1;
    for (int i = 1; i < 10; i += 2) {
        list1.push_back(i);
    }
    std::cout << list1 << std::endl;
    
    list1.splice(list1.begin(), list1);
    
    std::cout << list1 << std::endl;
}

- (void)testSplice4 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    std::list<int> list1;
    for (int i = 1; i < 10; i += 2) {
        list1.push_back(i);
    }
    std::cout << list1 << std::endl;
    
    auto it = list1.end();
    it --;
    list1.splice(list1.begin(), list1, it);
    
    std::cout << list1 << std::endl;
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
