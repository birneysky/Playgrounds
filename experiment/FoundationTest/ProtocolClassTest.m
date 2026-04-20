//
//  ProtocolClass.m
//  FoundationTest
//
//  Created by Bruce on 2026/4/20.
//

#import <XCTest/XCTest.h>
#import "Mediator.h"
#import "DetailViewControllerProtocol.h"

#import "TestMediator.h"
#import "TestViewControllerProtocol.h"


@interface ProtocolClassTest : XCTestCase

@end

@implementation ProtocolClassTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    Class cls =  [Mediator classFroProtocol:@protocol(DetailViewControllerProtocol)];
    UIViewController* vc  = [cls detailViewControllerWithURL:@"url"];
    XCTAssertEqual(vc.class, NSClassFromString(@"DetailViewController"));
}

- (void)testProtocolClass {
    Class<TestViewControllerProtocol> cls = [TestMediator classFroProtocol:@protocol(TestViewControllerProtocol)];
    UIViewController<TestViewControllerProtocol>* vc = [cls testViewControllerWithURL:@"Hello" arg1: 1 arg2: 2];
    [vc testWithArg:3];
    XCTAssertEqual(vc.class, NSClassFromString(@"TestViewController"));
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
