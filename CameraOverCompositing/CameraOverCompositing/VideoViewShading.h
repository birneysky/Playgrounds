//
//  VideoViewShading.h
//  CameraOverCompositing
//
//  Created by Bruce on 2021/7/20.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/gltypes.h>

NS_ASSUME_NONNULL_BEGIN

#define STRINGIZE(x) #x
#define STRINGIZE2(x) STRINGIZE(x)
#define SHADER_STRING(text) @ STRINGIZE2(text)

extern NSString *const vertexShader;
extern NSString *const fragmentShader;
extern NSString *const fragmentShader1;

@protocol VideoViewShading <NSObject>

- (void)applyShadingForFrameWithWidth:(int)width
                               height:(int)height
                               yPlane:(GLuint)yPlane
                              uvPlane:(GLuint)uvPlane;

@end


NS_ASSUME_NONNULL_END



