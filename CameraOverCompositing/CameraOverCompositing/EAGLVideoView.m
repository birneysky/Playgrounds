//
//  EAGLVideoView.m
//  CameraOverCompositing
//
//  Created by Bruce on 2021/7/20.
//

#import "EAGLVideoView.h"
#import "NV12TextureCache.h"

@interface EAGLVideoView ()

@property (nonatomic, readonly) NV12TextureCache* nv12TextureCache;
@property (nonatomic, assign)   GLuint frameBuffer;
@property (nonatomic, assign)   GLuint renderBuffer;
@property (nonatomic, assign)   GLint width;
@property (nonatomic, assign)   GLint height;
@end

@implementation EAGLVideoView {
    EAGLContext* _glContext;
    NV12TextureCache* _nv12TextureCache;
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
}

- (void)renderVideoPixelBuffer:(CVPixelBufferRef)buffer {
    OSType pixelFmt = CVPixelBufferGetPixelFormatType(buffer);
    assert(pixelFmt == kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange);
    
    if (!_nv12TextureCache) {
        _nv12TextureCache = [[NV12TextureCache alloc] initWithContext:_glContext];
    }
    
    [self.nv12TextureCache uploadTexturesDataWithPixelBuffer:buffer];
    /// applyShading vertext texture
    
    /// glDrawArrays
}

@end
