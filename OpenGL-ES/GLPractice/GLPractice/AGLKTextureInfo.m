//
//  AGLKTextureInfo.m
//  GLPractice
//
//  Created by birneysky on 2019/7/27.
//  Copyright © 2019 Grocery. All rights reserved.
//

#import "AGLKTextureInfo.h"

size_t AGLKCalculatePowerOf2Dimension(size_t value) {
    double Logarithm =  log2(value);
    size_t logarithmInt = (size_t)(round(Logarithm));
    return (size_t)pow(2, logarithmInt);
}


static NSData* AGLKDataWithResizedCGImageBytes(CGImageRef cgImage,
                                               size_t* widthPtr,
                                               size_t* heighPtr) {
    NSCParameterAssert(nil != cgImage);
    NSCParameterAssert(nil != widthPtr);
    NSCParameterAssert(nil != heighPtr);
    
    size_t originalWidth = CGImageGetWidth(cgImage);
    size_t originalHeight = CGImageGetHeight(cgImage);
    
    NSCAssert(originalWidth > 0, @"Invalid image width");
    NSCAssert(originalHeight > 0, @"Invalid image height");
    
    size_t width = AGLKCalculatePowerOf2Dimension(originalWidth);
    size_t height = AGLKCalculatePowerOf2Dimension(originalHeight);
    
    NSMutableData* imgData = [NSMutableData dataWithLength:width * height * 4];
    
    NSCAssert(nil != imgData,
              @"Unable to allocate image storage");
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef cgContext = CGBitmapContextCreate(imgData.mutableBytes,
                                                   width,
                                                   height,
                                                   8,
                                                   4 * width,
                                                   colorSpace,
                                                   kCGImageAlphaPremultipliedLast);
    
    CGColorSpaceRelease(colorSpace);
    
    CGContextTranslateCTM(cgContext, 0, height);
    CGContextScaleCTM(cgContext, 1.0f, -1.0);
    CGContextDrawImage(cgContext,
                       CGRectMake(0, 0, width, height),
                       cgImage);
    CGContextRelease(cgContext);
    
    *widthPtr = width;
    *heighPtr = height;
    return [imgData copy];
}


@implementation AGLKTextureInfo {
    GLuint _name;
    GLenum _target;
    GLuint _width;
    GLuint _height;
}

- (instancetype)initWithName:(GLuint)name
                      target:(GLenum)aTarget
                       width:(size_t)aWidth
                      height:(size_t)aHeight {
    if (self = [super init]) {
        _name = name;
        _target = aTarget;
        _width = (GLuint)aWidth;
        _height = (GLuint)aHeight;
    }
    return self;
}

+ (instancetype)textureWithCGImage:(CGImageRef)cgImage
                           options:(NSDictionary*)options
                             error:(NSError*)outErrors {
    size_t width = 0;
    size_t height = 0;
    
    NSData* imgData = AGLKDataWithResizedCGImageBytes(cgImage,
                                                      &width,
                                                      &height);
    
    GLuint textureBufferId = 0;
    glGenBuffers(1, &textureBufferId);
    glBindTexture(GL_TEXTURE_2D, textureBufferId);
    
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, (GLsizei)width, (GLsizei)height, 0, GL_RGBA, GL_UNSIGNED_BYTE, imgData.bytes);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    
    AGLKTextureInfo* info = [[AGLKTextureInfo alloc] initWithName:textureBufferId target:GL_TEXTURE_2D width:width height:height];
    return info;
}

@end
