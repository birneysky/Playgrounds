//
//  AGLKVertexAttributeArrayBuffer.h
//  GLPractice
//
//  Created by birneysky on 2019/7/24.
//  Copyright © 2019 Grocery. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GLKit;

NS_ASSUME_NONNULL_BEGIN

@interface AGLKVertexAttributeArrayBuffer : NSObject

@property (nonatomic, readonly) GLuint glName;
@property (nonatomic, readonly) GLsizeiptr bufferSizeBytes;
@property (nonatomic, readonly) GLsizeiptr stride; /// 每个顶点的数据长度


- (instancetype)initWithAttributeStride:(GLsizei)stride
                       numberOfVertices:(GLsizei)count
                                   data:(const GLvoid*)dataPrt
                                  usage:(GLenum)usage;

- (void)reinitWithAttribStride:(GLsizeiptr)aStride
              numberOfVertices:(GLsizei)count
                         bytes:(const GLvoid *)dataPtr;

- (void)prepareToDrawWithAttrib:(GLKVertexAttrib)attrib
            numberOfCoordinates:(GLint)count
                attributeOffset:(GLsizeiptr)offset /// 起始指针
                   shouldEnable:(BOOL)enable;

- (void)drawArrayWithMode:(GLenum)mode
         startVertexIndex:(GLint)first
         numberOfVertices:(GLsizei)count;

@end

NS_ASSUME_NONNULL_END
