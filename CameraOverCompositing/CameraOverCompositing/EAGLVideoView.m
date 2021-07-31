//
//  EAGLVideoView.m
//  CameraOverCompositing
//
//  Created by Bruce on 2021/7/20.
//

#import "EAGLVideoView.h"
#import "NV12TextureCache.h"
#import "VideoViewShading.h"
#import "NV12VAOShader.h"
#import "NV12Shader.h"

#import <AVFoundation/AVFoundation.h>

@interface EAGLVideoView ()

@property (nonatomic, readonly) NV12TextureCache* nv12TextureCache;
@property (nonatomic, assign)   GLuint frameBuffer;
@property (nonatomic, assign)   GLuint renderBuffer;
@property (nonatomic, assign)   GLint width;
@property (nonatomic, assign)   GLint height;
@property (nonatomic, readonly) id<VideoViewShading> shader;
@end

@implementation EAGLVideoView {
    EAGLContext* _glContext;
    NV12TextureCache* _nv12TextureCache;
    id<VideoViewShading> _shader;
    GLuint _frameBuffer;
    GLuint _renderBuffer;
    GLint _Width;
    GLint _Height;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setup];
        //[self setupContextAndBuffers];
    }
    return self;
}

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (void)setupContextAndBuffers {
    EAGLContext *glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    if (!glContext) {
      glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    }
    //glContext.multiThreaded = YES;
    BOOL success = [EAGLContext setCurrentContext:glContext];
    NSAssert(success == YES, @"EAGLContext setCurrentContext failed");
    
    NSAssert(glContext, @"EAGLContext alloc failed");
    _glContext = glContext;
    
    glGenFramebuffers(1, &_frameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _frameBuffer);
    glGenRenderbuffers(1, &_renderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _renderBuffer);
   dispatch_sync(dispatch_get_main_queue(), ^{
       [glContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer*)self.layer];
    });
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &_width);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &_height);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _renderBuffer);
    
    GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
    NSAssert(status == GL_FRAMEBUFFER_COMPLETE, @"failed to make complete framebuffer object %x",status);
    
    
    GLenum glError = glGetError();
    NSAssert(glError == GL_NO_ERROR, @"failed to setup GL %x",glError);
    _shader = [[NV12VAOShader alloc] init];
    [EAGLContext setCurrentContext:glContext];
}

- (void)setup {
    self.contentScaleFactor = [[UIScreen mainScreen] scale]; /// 不设置该值，会出现锯齿
    CAEAGLLayer *eaglLayer = (CAEAGLLayer*) self.layer;
    eaglLayer.opaque = YES;
    eaglLayer.drawableProperties = @{
        kEAGLDrawablePropertyRetainedBacking:@(NO),
        kEAGLDrawablePropertyColorFormat:kEAGLColorFormatRGBA8
    };
}

- (void)renderVideoPixelBuffer:(CVPixelBufferRef)buffer {
 //   NSLog(@"%@",[NSThread currentThread]);
    OSType pixelFmt = CVPixelBufferGetPixelFormatType(buffer);
    assert(pixelFmt == kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange);
    
    size_t width  = CVPixelBufferGetWidth(buffer);
    size_t height = CVPixelBufferGetHeight(buffer);
    
    if (!_glContext) {
        [self setupContextAndBuffers];
    }
    
    if ([EAGLContext currentContext] != _glContext) {
       NSLog(@"EAGLContext currentContext is not _glContext");
        [EAGLContext setCurrentContext:_glContext];
    }

    glBindFramebuffer(GL_FRAMEBUFFER, _frameBuffer);
    if (!_nv12TextureCache) {
        _nv12TextureCache = [[NV12TextureCache alloc] initWithContext:_glContext];
        CGRect rect = AVMakeRectWithAspectRatioInsideRect(CGSizeMake(width, height), (CGRect){0, 0, _width, _height});
        glViewport(rect.origin.x, rect.origin.y, (GLsizei)rect.size.width, (GLsizei)rect.size.height);
    }
    
    [self.nv12TextureCache uploadTexturesDataWithPixelBuffer:buffer];
    /// applyShading vertext texture
//    [self.shader applyShadingForFrameWithWidth:(int)width
//                                        height:(int)height
//                                        yPlane:self.nv12TextureCache.yTexture
//                                       uvPlane:self.nv12TextureCache.uvTexture];
    GLuint tids[] = {self.nv12TextureCache.yTexture, self.nv12TextureCache.uvTexture};
    [self.shader applyShadingForFrameWithWidth:(int)width height:(int)height textureIds:tids length:2];

    glBindRenderbuffer(GL_RENDERBUFFER, _renderBuffer);
    [_glContext presentRenderbuffer:GL_RENDERBUFFER];
}


@end
