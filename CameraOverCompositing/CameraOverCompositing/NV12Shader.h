//
//  NV12Shader.h
//  CameraOverCompositing
//
//  Created by Bruce on 2021/7/20.
//

#import <Foundation/Foundation.h>
#import "VideoViewShading.h"
NS_ASSUME_NONNULL_BEGIN

@interface NV12Shader : NSObject <VideoViewShading>

- (void)applyShadingForFrameWithWidth:(int)width
                               height:(int)height
                               yPlane:(GLuint)yPlane
                              uvPlane:(GLuint)uvPlane;

@end

NS_ASSUME_NONNULL_END
