//
//  CompositingTextureCache.m
//  CameraOverCompositing
//
//  Created by birneysky on 2021/8/4.
//

#import "CompositingTextureCache.h"

@interface CompositingTextureCache ()

@property (nonatomic, readonly) GLuint yTexture;
@property (nonatomic, readonly) GLuint uvTexture;
@property (nonatomic, readonly) GLuint rgbaTexture;
@property (nonatomic, readonly) NSMutableArray<NSData*>* imageDatas;
@end

NSData* rbgaDataForImage(CGImageRef imgRef) {
    NSUInteger iWidth = CGImageGetWidth(imgRef);
    NSUInteger iHeight = CGImageGetHeight(imgRef);
    NSUInteger iBytesPerPixel = 4;
    NSUInteger iBytesPerRow = iBytesPerPixel * iWidth;
    NSUInteger iBitsPerComponent = 8;
    unsigned char *imageBytes = malloc(iWidth * iHeight * iBytesPerPixel);

    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();

    CGContextRef context = CGBitmapContextCreate(imageBytes,
                                                iWidth,
                                                iHeight,
                                                iBitsPerComponent,
                                                iBytesPerRow,
                                                colorspace,
                                                kCGImageAlphaPremultipliedLast);

    CGRect rect = CGRectMake(0 , 0 , iWidth , iHeight);
    CGContextDrawImage(context , rect ,imgRef);
    NSData* data = [NSData dataWithBytes:imageBytes length:iWidth * iHeight * 4];
    CGColorSpaceRelease(colorspace);
    CGContextRelease(context);
    free(imageBytes);
    return data;
    //return rgbaData;
}

@implementation CompositingTextureCache {
    CVOpenGLESTextureCacheRef _textureCache;
    CVOpenGLESTextureRef _yTextureRef;
    CVOpenGLESTextureRef _uvTextureRef;
    GLuint _rgbaTexture;
    NSMutableArray<NSData*>* _imageDatas;
    GLuint _textureIds[3];
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
      
      NSString* path = [[NSBundle mainBundle] pathForResource:@"poke_sticker" ofType:@"gif"];
      NSData* data = [NSData dataWithContentsOfFile:path];
      
      CGImageSourceRef sourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)data, nil);
      
      NSInteger count = CGImageSourceGetCount(sourceRef);
      for (int i = 0; i < count; i ++) {
          CGImageRef cgImg = CGImageSourceCreateImageAtIndex(sourceRef, i, nil);
          NSData* data =  rbgaDataForImage(cgImg);
          [self.imageDatas addObject:data];
          
          CGImageRelease(cgImg);
      }
      CFRelease(sourceRef);
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

- (GLuint)yTexture {
  return CVOpenGLESTextureGetName(_yTextureRef);
}

- (GLuint)uvTexture {
    return CVOpenGLESTextureGetName(_uvTextureRef);
}

- (GLuint)rgbaTexture {
    return _rgbaTexture;
}

- (NSMutableArray<NSData*>*)imageDatas {
    if (!_imageDatas) {
        _imageDatas = [[NSMutableArray alloc] init];
    }
    return _imageDatas;
}

- (void)loadTextureWithRGBAImageData:(NSData*)data size:(CGSize)size {
    if (_rgbaTexture == 0) {
        glGenTextures(1, &_rgbaTexture);
    }
    
    glBindTexture(GL_TEXTURE_2D, _rgbaTexture);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA,
                 (GLsizei)size.width, (GLsizei)size.height,
                 0, GL_RGBA, GL_UNSIGNED_BYTE, data.bytes);
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



- (GLuint*)textureIds {
    _textureIds[0] = self.yTexture;
    _textureIds[1] = self.uvTexture;
    _textureIds[2] = self.rgbaTexture;
    return _textureIds;
}

- (int)textureCount {
    return 3;
}

- (BOOL)uploadTexturesDataWithPixelBuffer:(CVPixelBufferRef)pixelBuffer {
    OSType pixelFmt = CVPixelBufferGetPixelFormatType(pixelBuffer);
    assert(pixelFmt == kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange);
    static NSUInteger count = 0;
    [self loadTextureWithRGBAImageData:self.imageDatas[count% (self.imageDatas.count)]
                                  size:(CGSize){240,240}];
    count++;
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
