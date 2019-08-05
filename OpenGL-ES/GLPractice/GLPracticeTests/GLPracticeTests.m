//
//  GLPracticeTests.m
//  GLPracticeTests
//
//  Created by birneysky on 2019/7/23.
//  Copyright © 2019 Grocery. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SceneVertex.h"

@interface GLPracticeTests : XCTestCase

@end

@implementation GLPracticeTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)test_AVector3Length {
    /// 求矢量的长度
    NSLog(@"input vector3: {1.0f,1.0f,1.0f}");
    GLKVector3 avec1 = {1.0f,1.0f,1.0f};
    GLfloat length1 =  AVector3Length(avec1);
    NSLog(@"output length1 = %f",length1);
    
    NSLog(@"input vector3: {3.0f,4.0f,0.0f}");
    GLKVector3 avec2 = {3.0f,4.0f,0.0f};
    GLfloat length2 =  AVector3Length(avec2);
    NSLog(@"output length2 = %f",length2);
}

- (void)test_AVector3CrossProduct {
    ///  求矢量积，矢量积总是与两个矢量所在的平面垂直
    GLKVector3 a1 = {1.0f, 0.0f, 0.0f};
    GLKVector3 b1 = {0.0f, 1.0f, 0.0f};
    NSLog(@"input vector a1 {1.0f, 0.0f, 0.0f}");
    NSLog(@"input vector b1 {0.0f, 1.0f, 0.0f}");
    GLKVector3 result1 = AVector3CrossProduct(a1, b1);
    NSLog(@"output result1: x=%f,y=%f,z=%f",result1.x,result1.y,result1.z);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
