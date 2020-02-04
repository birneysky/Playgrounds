//
//  BlockCaptureVarTests.m
//  FoundationTest
//
//  Created by birney on 2020/1/19.
//

#import <XCTest/XCTest.h>

@interface BlockCaptureVarTests : XCTestCase

@end

@implementation BlockCaptureVarTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTestExpectation* expectation = [self expectationWithDescription:@"document open"];
    dispatch_queue_t queue = dispatch_queue_create("cn.rongcloud.room.queue", DISPATCH_QUEUE_SERIAL);
    int a = 3;
    a = 4;
    a += 6;
    
    dispatch_async(queue, ^{
        NSLog(@"%d", a);
        [expectation fulfill];
    });
    
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
