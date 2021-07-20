//
//  NV12TextureCache.m
//  LiveStreamDemo
//
//  Created by Bruce on 2021/7/17.
//

#import "NV12TextureCache.h"

@implementation NV12TextureCache {
    CVOpenGLESTextureCacheRef _textureCache;
    CVOpenGLESTextureRef _yTextureRef;
    CVOpenGLESTextureRef _uvTextureRef;
}


- (GLuint)yTexture {
  return CVOpenGLESTextureGetName(_yTextureRef);
}

- (GLuint)uvTexture {
  return CVOpenGLESTextureGetName(_uvTextureRef);
}

- (instancetype)initWithContext:(EAGLContext *)context {
  if (self = [super init]) {
    CVReturn ret = CVOpenGLESTextureCacheCreate(kCFAllocatorDefault,
                                                NULL,
                                                context,
                                                NULL,
                                                &_textureCache);
    if (ret != kCVReturnSuccess) {
      self = nil;
    }
  }
  return self;
}

- (void)dealloc {
  [self releaseTextures];
  if (_textureCache) {
    CFRelease(_textureCache);
    _textureCache = nil;
  }
}

- (BOOL)loadTexture:(CVOpenGLESTextureRef *)textureOut
        pixelBuffer:(CVPixelBufferRef)pixelBuffer
         planeIndex:(int)planeIndex
        pixelFormat:(GLenum)pixelFormat {
  const size_t width = CVPixelBufferGetWidthOfPlane(pixelBuffer, planeIndex);
  const size_t height = CVPixelBufferGetHeightOfPlane(pixelBuffer, planeIndex);

  if (*textureOut) {
    CFRelease(*textureOut);
    *textureOut = nil;
  }
  CVReturn ret = CVOpenGLESTextureCacheCreateTextureFromImage(kCFAllocatorDefault,
                    _textureCache, pixelBuffer, NULL, GL_TEXTURE_2D, pixelFormat,
                    (GLsizei)width, (GLsizei)height, pixelFormat, GL_UNSIGNED_BYTE, planeIndex, textureOut);
  if (ret != kCVReturnSuccess) {
    CFRelease(*textureOut);
    *textureOut = nil;
    return NO;
  }
  NSAssert(CVOpenGLESTextureGetTarget(*textureOut) == GL_TEXTURE_2D,
           @"Unexpected GLES texture target");
  glBindTexture(GL_TEXTURE_2D, CVOpenGLESTextureGetName(*textureOut));
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
  return YES;
}

- (BOOL)uploadTexturesDataWithPixelBuffer:(CVPixelBufferRef)pixelBuffer {
    OSType pixelFmt = CVPixelBufferGetPixelFormatType(pixelBuffer);
    assert(pixelFmt == kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange);
    return [self loadTexture:&_yTextureRef
                 pixelBuffer:pixelBuffer
                  planeIndex:0
                 pixelFormat:GL_LUMINANCE] &&
            [self loadTexture:&_uvTextureRef
                  pixelBuffer:pixelBuffer
                   planeIndex:1
                  pixelFormat:GL_LUMINANCE_ALPHA];
}

- (void)releaseTextures {
  if (_uvTextureRef) {
    CFRelease(_uvTextureRef);
    _uvTextureRef = nil;
  }
  if (_yTextureRef) {
    CFRelease(_yTextureRef);
    _yTextureRef = nil;
  }
}

@end
