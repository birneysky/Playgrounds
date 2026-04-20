//
//  TestViewControllerProtocol.h
//  FoundationTest
//
//  Created by Bruce on 2026/4/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UIViewController;
@protocol TestViewControllerProtocol <NSObject>

+ (__kindof UIViewController<TestViewControllerProtocol>*)testViewControllerWithURL:(NSString*)url arg1:(NSInteger)arg1 arg2:(NSInteger)arg2;

- (void)testWithArg:(NSInteger)a;

@end

NS_ASSUME_NONNULL_END
