//
//  VideoRender.h
//  CameraOverCompositing
//
//  Created by Bruce on 2021/7/20.
//

#import <CoreVideo/CoreVideo.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VideoRender <NSObject>

- (void)renderVideoPixelBuffer:(CVPixelBufferRef)frame;

@end

NS_ASSUME_NONNULL_END
