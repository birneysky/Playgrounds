//
//  AGLKVertexAttributeArrayBuffer.m
//  GLPractice
//
//  Created by birneysky on 2019/7/24.
//  Copyright © 2019 Grocery. All rights reserved.
//

#import "AGLKVertexAttributeArrayBuffer.h"

@interface AGLKVertexAttributeArrayBuffer ()

@property (nonatomic, assign) GLuint glName;
@property (nonatomic, assign) GLsizeiptr bufferSizeBytes;
@property (nonatomic, assign) GLsizei stride;

@end

@implementation AGLKVertexAttributeArrayBuffer

- (instancetype)initWithAttributeStride:(GLsizei)stride
                       numberOfVertices:(GLsizei)count
                                   data:(const GLvoid*)dataPrt
                                  usage:(GLenum)usage {
    NSParameterAssert(stride > 0);
    NSParameterAssert(count > 0);
    NSParameterAssert(dataPrt != nil);
    
    if (self = [super init]) {
        _stride = stride;
        _bufferSizeBytes = stride * count;
        glGenBuffers(1, &_glName); /// 1 生成buffer id
        glBindBuffer(GL_ARRAY_BUFFER, _glName); /// 2 绑定buffer
        /// 3 初始化buffer内容
        glBufferData(GL_ARRAY_BUFFER,
                     _bufferSizeBytes,
                     dataPrt,
                     usage);
    }
    return self;
}

- (void)prepareToDrawWithAttrib:(GLKVertexAttrib)attrib
            numberOfCoordinates:(GLint)count
                attributeOffset:(const GLvoid*)offset
                   shouldEnable:(BOOL)enable {
    NSParameterAssert(count > 0 && count < 4);
    NSAssert(0 != _glName, @"invalid glname");
    
    if (enable) {
        glEnableVertexAttribArray(attrib); /// 4
    }
    
    /// 5 
    glVertexAttribPointer(attrib,
                          count,
                          GL_FLOAT,
                          GL_FALSE,
                          _stride,
                          offset);
}

- (void)drawArrayWithMode:(GLenum)mode
         startVertexIndex:(GLint)first
         numberOfVertices:(GLsizei)count {
    NSAssert(self.bufferSizeBytes >= (first + count) * self.stride,
             @"attempt to draw more vertex data than available");
    
    glDrawArrays(mode, first, count);
}

- (void)dealloc {
    if (0 != _glName) {
        glDeleteBuffers(1, &_glName);
        _glName = 0;
    }
}

@end
