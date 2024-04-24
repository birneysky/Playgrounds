//
//  ColorTests.m
//  TestXcodePreviewTests
//
//  Created by Bruce on 2024/4/9.
//

#import <XCTest/XCTest.h>
#import "TestXcodePreview-Swift.h"

@interface ColorTests : XCTestCase

@end

@implementation ColorTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    XCTAssert([UIColor.clearColor isEqual:UIColor.clearColor]);
    UnitTestClass* testClas =  [[UnitTestClass alloc] init];
    XCTAssert([testClas isKindOfClass:UnitTestClass.class]);
    //[[KTVAchievementEntranceViewController alloc] init];
    KTVAchievementEntranceViewController* a = [KTVAchievementEntranceViewController controller];
    XCTAssert([a isKindOfClass: KTVAchievementEntranceViewController.class]);
    
    KTVEntranceItemView* itemView = [KTVEntranceItemView view];
    XCTAssert([itemView isKindOfClass: KTVEntranceItemView.class]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
