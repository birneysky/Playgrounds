//
//  ReverseSentenceTest.m
//  KataTest
//
//  Created by birneysky on 2020/7/2.
//

#import <XCTest/XCTest.h>
#import "ReverseSentence.hpp"
#include <iostream>

@interface ReverseSentenceTest : XCTestCase

@end

@implementation ReverseSentenceTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    char pBegin[] = "are you ok";
    ReverseSentence(pBegin);
    std::cout << pBegin << std::endl;
    char pBegin2[] = "I have a very import annoucement to make";
    ReverseSentence(pBegin2);
    std::cout << pBegin2 << std::endl;
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
