//
//  OCInstanceVarAccessControlTest.m
//  FoundationTest
//
//  Created by birney on 2020/3/3.
//

#import <XCTest/XCTest.h>
#import "Object.h"
#import "ObjectA.h"

@interface OCInstanceVarAccessControlTest : XCTestCase

@end

@implementation OCInstanceVarAccessControlTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.

}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    Object* obj = [[Object alloc] init];
    
    /// instance variable '_var1' is protected
    //XCTAssertEqual(obj->_var1, 82);
    XCTAssertEqual(obj->_var2, 62);
     /// instance variable '_var3' is protected
    //XCTAssertEqual(obj->_var3, 82);
    //XCTAssertEqual(obj->_var4, 82);
     /// instance variable '_var5' is private
    //XCTAssertEqual(obj->_var5, 82);
    /// 'object' dees not have a memeber named '_var6'
    //XCTAssertEqual(obj->_var6, 82);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
