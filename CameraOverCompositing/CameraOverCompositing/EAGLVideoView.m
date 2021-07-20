//
//  EAGLVideoView.m
//  CameraOverCompositing
//
//  Created by Bruce on 2021/7/20.
//

#import "EAGLVideoView.h"
#import "NV12TextureCache.h"
#import "VideoViewShading.h"
#import "NV12Shader.h"

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
    }
    return self;
}

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (void)setup {
    EAGLContext *glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    if (!glContext) {
      glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    }
    
    NSAssert(glContext, @"EAGLContext alloc failed");
    _glContext = glContext;
    
    BOOL success = [EAGLContext setCurrentContext:glContext];
    NSAssert(success == YES, @"EAGLContext setCurrentContext failed");
    CAEAGLLayer *eaglLayer = (CAEAGLLayer*) self.layer;
    eaglLayer.opaque = YES;
    eaglLayer.drawableProperties = @{
        kEAGLDrawablePropertyRetainedBacking:@(NO),
        kEAGLDrawablePropertyColorFormat:kEAGLColorFormatRGBA8
    };
    
    glGenFramebuffers(1, &_frameBuffer);
    glGenRenderbuffers(1, &_renderBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _frameBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _renderBuffer);
    [glContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer*)self.layer];
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &_width);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &_height);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _renderBuffer);
    
    GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
    NSAssert(status == GL_FRAMEBUFFER_COMPLETE, @"failed to make complete framebuffer object %x",status);
    
    
    GLenum glError = glGetError();
    NSAssert(glError == GL_NO_ERROR, @"failed to setup GL %x",glError);
    _shader = [[NV12Shader alloc] init];
}

- (void)renderVideoPixelBuffer:(CVPixelBufferRef)buffer {
    OSType pixelFmt = CVPixelBufferGetPixelFormatType(buffer);
    assert(pixelFmt == kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange);
    
    size_t width = CVPixelBufferGetWidth(buffer);
    size_t height = CVPixelBufferGetHeight(buffer);
    
    if ([EAGLContext currentContext] != _glContext) {
      [EAGLContext setCurrentContext:_glContext];
    }
    
    glBindFramebuffer(GL_FRAMEBUFFER, _frameBuffer);
    glViewport(0, 0, (GLsizei)width, (GLsizei)height);
    if (!_nv12TextureCache) {
        _nv12TextureCache = [[NV12TextureCache alloc] initWithContext:_glContext];
    }
    
    [self.nv12TextureCache uploadTexturesDataWithPixelBuffer:buffer];
    /// applyShading vertext texture
    [self.shader applyShadingForFrameWithWidth:(int)width
                                        height:(int)height
                                        yPlane:self.nv12TextureCache.yTexture
                                       uvPlane:self.nv12TextureCache.uvTexture];
    

    glBindRenderbuffer(GL_RENDERBUFFER, _renderBuffer);
    [_glContext presentRenderbuffer:GL_RENDERBUFFER];
}

@end
