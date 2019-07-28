//
//  AGLKTextureInfo.h
//  GLPractice
//
//  Created by birneysky on 2019/7/27.
//  Copyright © 2019 Grocery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AGLKTextureInfo : NSObject

@property (nonatomic, readonly) GLuint name;
@property (nonatomic, readonly) GLenum target;
@property (nonatomic, readonly) GLuint width;
@property (nonatomic, readonly) GLuint height;

+ (instancetype)textureWithCGImage:(CGImageRef)cgImage
                           options:(NSDictionary*)options
                             error:(NSError*)outErrors;

@end

NS_ASSUME_NONNULL_END
