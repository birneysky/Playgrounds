//
//  TestMediator.h
//  FoundationTest
//
//  Created by Bruce on 2026/4/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestMediator : NSObject

+ (void)registerProtocol:(Protocol*)protocol class:(Class)cls;
+ (Class)classFroProtocol:(Protocol*)protocol;

@end

NS_ASSUME_NONNULL_END
