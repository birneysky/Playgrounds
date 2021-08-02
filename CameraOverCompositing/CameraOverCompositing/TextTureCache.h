//
//  TextTureCache.h
//  CameraOverCompositing
//
//  Created by birneysky on 2021/8/2.
//


#import <Foundation/Foundation.h>
#import <CoreVideo/CoreVideo.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TextTureCache <NSObject>

- (GLuint*)textureIds;

- (int)textureCount;

- (BOOL)uploadTexturesDataWithPixelBuffer:(CVPixelBufferRef)pixelBuffer;

@end

NS_ASSUME_NONNULL_END
