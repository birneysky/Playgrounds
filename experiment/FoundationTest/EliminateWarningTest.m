//
//  EliminateWarningTest.m
//  FoundationTest
//
//  Created by birney on 2019/10/25.
//

#import <XCTest/XCTest.h>
#import <objc/message.h>
#import "TestObject.h"

@interface EliminateWarningTest : XCTestCase

@end

@implementation EliminateWarningTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    //self.continueAfterFailure = NO;

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    //[[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)test_non_null_warning {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    ///  警告消除大法
    /// warning Null passed to a callee that requires a non-null argument
    ///  参考文档 https://releases.llvm.org/8.0.0/tools/clang/docs/DiagnosticsReference.html
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    [NSArray arrayWithArray:nil];
#pragma clang diagnostic pop
}

- (void)test_undeclared_selector_warning {
    ///  Undeclared selector 'doSomething'
    ///  参考文档 https://releases.llvm.org/8.0.0/tools/clang/docs/DiagnosticsReference.html
    ///  也可以关闭 building setting--->  Apple Clang-warnings-objective-c ----> undeclared selector 选项
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    TestObject* object = [[TestObject alloc] init];
    ((id (*)(id, SEL))objc_msgSend)(object,@selector(doSomething));
#pragma clang diagnostic pop
}

@end
