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
@property (nonatomic, assign) GLsizeiptr stride;

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
        /// 1 生成buffer id
        glGenBuffers(1, &_glName);
         /// 2 绑定buffer
        glBindBuffer(GL_ARRAY_BUFFER, _glName);
        /// 3 初始化buffer内容
        glBufferData(GL_ARRAY_BUFFER,
                     _bufferSizeBytes,
                     dataPrt,
                     usage);
    }
    return self;
}

- (void)reinitWithAttribStride:(GLsizeiptr)aStride
              numberOfVertices:(GLsizei)count
                         bytes:(const GLvoid *)dataPtr {
    NSParameterAssert(0 < aStride);
    NSParameterAssert(0 < count);
    NSParameterAssert(NULL != dataPtr);
    NSAssert(0 != _glName, @"Invalid name");
    
    self.stride = aStride;
    self.bufferSizeBytes = aStride * count;
    
    glBindBuffer(GL_ARRAY_BUFFER,  // STEP 2
                 _glName);
    glBufferData(GL_ARRAY_BUFFER,  // Initialize buffer contents
                 _bufferSizeBytes,  // Number of bytes to copy
                 dataPtr,          // Address of bytes to copy
                 GL_DYNAMIC_DRAW);
}

- (void)prepareToDrawWithAttrib:(GLKVertexAttrib)attrib
            numberOfCoordinates:(GLint)count
                attributeOffset:(GLsizeiptr)offset
                   shouldEnable:(BOOL)enable {
    NSParameterAssert(count > 0 && count < 4);
    NSAssert(0 != _glName, @"invalid glname");
    
    if (enable) {
        /// 4 启动顶点缓存渲染操作
        glEnableVertexAttribArray(attrib);
    }
    
    /// 5  告诉 OPENGL 顶点数据在哪里，以及怎么解析每个顶点保存的数据
    glVertexAttribPointer(attrib,/// 每个顶点数据的类型
                          count, /// 每个顶点数据的分量个数
                          GL_FLOAT, /// 每个顶点数据分量的类型
                          GL_FALSE, /// 小数点固定数据是否可以被改变
                          _stride, /// 每个顶点数据的字节长度
                          NULL + offset);
}

- (void)drawArrayWithMode:(GLenum)mode
         startVertexIndex:(GLint)first
         numberOfVertices:(GLsizei)count {
    NSAssert(self.bufferSizeBytes >= (first + count) * self.stride,
             @"attempt to draw more vertex data than available");
    /// 6 执行绘图，
    glDrawArrays(mode, /// 告诉GPU 怎么处理在绑定的顶点缓存内的顶点数据
                 first, /// 首个顶点的位置
                 count); /// 需要渲染的顶点数量
}

- (void)dealloc {
    if (0 != _glName) {
        /// 7 删除顶点缓存
        glDeleteBuffers(1, &_glName);
        _glName = 0;
    }
}

@end
