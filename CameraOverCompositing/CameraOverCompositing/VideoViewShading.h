//
//  VideoViewShading.h
//  CameraOverCompositing
//
//  Created by Bruce on 2021/7/20.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/gltypes.h>
NS_ASSUME_NONNULL_BEGIN

@protocol VideoViewShading <NSObject>

- (void)applyShadingForFrameWithWidth:(int)width
                               height:(int)height
                               yPlane:(GLuint)yPlane
                              uvPlane:(GLuint)uvPlane;

@end

NS_ASSUME_NONNULL_END
