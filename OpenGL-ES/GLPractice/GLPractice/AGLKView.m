//
//  AGLKView.m
//  GLPractice
//
//  Created by birney on 2019/7/24.
//  Copyright © 2019 Grocery. All rights reserved.
//

#import "AGLKView.h"
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@implementation AGLKView {
    GLuint _defaultFrameBuffer;
    GLuint _colorRenderBuffer;
    GLuint _depthRenderBuffer;
    GLint _drawableWidth;
    GLint _drawableHeight;
}

+ (Class)layerClass {
    return [CAEAGLLayer class];
}


- (instancetype)initWithFrame:(CGRect)frame context:(EAGLContext *)aContext {
    if (self = [super initWithFrame:frame]) {
        CAEAGLLayer* egaLayer = (CAEAGLLayer*)self.layer;
        egaLayer.drawableProperties =   @{ kEAGLDrawablePropertyRetainedBacking:@(NO),
                                           kEAGLDrawablePropertyColorFormat:kEAGLColorFormatRGBA8
                                          };
        self.context = aContext;
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        CAEAGLLayer* egaLayer = (CAEAGLLayer*)self.layer;
        egaLayer.drawableProperties =   @{ kEAGLDrawablePropertyRetainedBacking:@(NO),
                                           kEAGLDrawablePropertyColorFormat:kEAGLColorFormatRGBA8
                                           };
    }
    return self;
}

- (NSInteger)drawableWidth {
    GLint backingWidth;
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &backingWidth);
    return (NSInteger)backingWidth;
}

- (NSInteger)drawableHeight {
    GLint backingHeight;
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &backingHeight);
    
    return (NSInteger)backingHeight;
}

- (void)setContext:(EAGLContext *)acontext {
    if (_context != acontext) {
        /// 删除缓存前，设置为老的上下文
        [EAGLContext setCurrentContext:_context];
        if (0 != _defaultFrameBuffer) {
            glDeleteBuffers(1, &_defaultFrameBuffer);
            _defaultFrameBuffer = 0;
        }
        
        if (0 != _colorRenderBuffer) {
            glDeleteBuffers(1, &_colorRenderBuffer);
            _colorRenderBuffer = 0;
        }
        
        if (0 != _depthRenderBuffer) {
            glDeleteBuffers(1, &_depthRenderBuffer);
            _depthRenderBuffer = 0;
        }
        
        _context = acontext;
        
        if (nil != _context) {
            [EAGLContext setCurrentContext:_context];
            
            glGenFramebuffers(1, &_defaultFrameBuffer);
            glBindFramebuffer(GL_FRAMEBUFFER, _defaultFrameBuffer);
            
            glGenRenderbuffers(1, &_colorRenderBuffer);
            glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
            
            // Attach color render buffer to bound Frame Buffer
            glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderBuffer);
            
            [self layoutSubviews];
        }
        
    }
}

- (void)drawRect:(CGRect)rect {
    if (self.delegate) {
        [self.delegate glkView:self drawInRect:self.bounds];
    }
}

- (void)layoutSubviews {
    CAEAGLLayer* eaglLayer = (CAEAGLLayer*)self.layer;
    [EAGLContext setCurrentContext:self.context];
    [self.context renderbufferStorage:GL_RENDERBUFFER fromDrawable:eaglLayer];
    if (0 != _depthRenderBuffer) {
        glDeleteBuffers(1, &_depthRenderBuffer);
        _depthRenderBuffer = 0;
    }
    
    GLint currentDrawableWidth = (GLint)self.drawableWidth;
    GLint currentDrawableHeight = (GLint)self.drawableHeight;
    
    if (AGLKViewDrawableDepthFormatNone != self.drawableDepthFormat &&
        currentDrawableWidth > 0 &&
        currentDrawableHeight > 0) {
        glGenRenderbuffers(1, &_depthRenderBuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, _depthRenderBuffer);
        glRenderbufferStorage(GL_RENDERBUFFER,
                              GL_DEPTH_COMPONENT16,
                              currentDrawableHeight,
                              currentDrawableHeight);
        
        glFramebufferRenderbuffer(GL_FRAMEBUFFER,
                                  GL_DEPTH_ATTACHMENT,
                                  GL_RENDERBUFFER,
                                  _depthRenderBuffer);
    }
    
    GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
    if (GL_FRAMEBUFFER_COMPLETE != status) {
         NSLog(@"failed to make complete frame buffer object %x", status);
    }
    
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    
}

- (void)display {
    [EAGLContext setCurrentContext:self.context];
    glViewport(0, 0, (GLint)self.drawableWidth, (GLint)self.drawableHeight);
    [self drawRect:self.bounds];
    [self.context presentRenderbuffer:GL_RENDERBUFFER];
}


- (void)dealloc {
    if (EAGLContext.currentContext == _context) {
        [EAGLContext setCurrentContext:nil];
    }
    _context = nil;
}

@end
