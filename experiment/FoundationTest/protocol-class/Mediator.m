//
//  Mediator.m
//  FoundationTest
//
//  Created by Bruce on 2026/4/20.
//

#import "Mediator.h"

@implementation Mediator
// 使用静态变量保存映射表，并在第一次使用时懒加载
static NSMutableDictionary<NSString *, Class> *protocolCache = nil;

+ (NSMutableDictionary *)caches {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        protocolCache = [[NSMutableDictionary alloc] init];
    });
    return protocolCache;
}

+ (void)registerProtocol:(Protocol*)protocol class:(Class)cls {
        if(protocol  && cls) {
        [self.caches setObject:cls forKey:NSStringFromProtocol(protocol)];
    }
}
+ (Class)classFroProtocol:(Protocol*)protocol {
    if (protocol) {
        NSString *protocolName = NSStringFromProtocol(protocol);
        return [[self caches] objectForKey:protocolName];
    }
    return nil;
}

@end
