//
//  CompositingTextureCache.h
//  CameraOverCompositing
//
//  Created by birneysky on 2021/8/4.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "TextTureCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompositingTextureCache : NSObject <TextTureCache>

- (instancetype)init NS_UNAVAILABLE;
- (nullable instancetype)initWithContext:(EAGLContext *)context;

- (BOOL)uploadTexturesDataWithPixelBuffer:(CVPixelBufferRef)pixelBuffer;


@end

NS_ASSUME_NONNULL_END
