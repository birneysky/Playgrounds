//
//  NV12TextureCache.h
//  LiveStreamDemo
//
//  Created by Bruce on 2021/7/17.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NV12TextureCache : NSObject

@property (nonatomic, readonly) GLuint yTexture;
@property (nonatomic, readonly) GLuint uvTexture;

- (instancetype)init NS_UNAVAILABLE;
- (nullable instancetype)initWithContext:(EAGLContext *)context;

- (BOOL)uploadTexturesDataWithPixelBuffer:(CVPixelBufferRef)pixelBuffer;
@end

NS_ASSUME_NONNULL_END
