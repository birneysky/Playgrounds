//
//  AGLKContext.h
//  GLPractice
//
//  Created by birneysky on 2019/7/24.
//  Copyright © 2019 Grocery. All rights reserved.
//

@import GLKit;

NS_ASSUME_NONNULL_BEGIN

@interface AGLKContext : EAGLContext

@property (nonatomic, assign) GLKVector4 clearColor;

- (void)clear:(GLbitfield)mask;

@end

NS_ASSUME_NONNULL_END
