//
//  AGLKContext.m
//  GLPractice
//
//  Created by birneysky on 2019/7/24.
//  Copyright © 2019 Grocery. All rights reserved.
//

#import "AGLKContext.h"

@implementation AGLKContext


/**
 设置上下文中帧缓存中每个像素的颜色值

 @param aclearColor 颜色值
 */
- (void)setClearColor:(GLKVector4)aclearColor {
    _clearColor = aclearColor;
    
    NSAssert(self == [[self class] currentContext],
             @"Recving context required to be current context");
    
    glClearColor(aclearColor.r,
                 aclearColor.g,
                 aclearColor.b,
                 aclearColor.a);
}


- (void)clear:(GLbitfield)mask {
    NSAssert(self == [[self class] currentContext],
             @"Recving context required to be current context");
    
    glClear(mask);
}

@end
