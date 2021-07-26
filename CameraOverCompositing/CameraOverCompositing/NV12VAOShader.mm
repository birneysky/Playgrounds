//
//  NV12VAOShader.m
//  CameraOverCompositing
//
//  Created by Bruce on 2021/7/22.
//

#import "NV12VAOShader.h"
#include "ShadingHelper.h"
#import "VideoViewShading.h"

#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/ES3/glext.h>
#import <OpenGLES/gltypes.h>



static const int kYTextureUnit = 0;
static const int kUvTextureUnit = 1;

@implementation NV12VAOShader {
    GLuint _nv12Program;
    GLint  _position;
    GLint _textureCoord;
    GLint _InputTextureUniform;
    GLuint _vao;
    GLuint _vbo;
}

- (void)dealloc {
    glDeleteProgram(_nv12Program);
    glDeleteBuffers(1, &_vbo);
    glDeleteVertexArrays(1, &_vao);
}

- (BOOL)buildProgramWithVertextShader:(NSString*)vertexShader
                       fragmentShader:(NSString*) fragmentShader {
    BOOL result = NO;
    GLuint vertShader = 0, fragShader = 0;
    _nv12Program = glCreateProgram();
    vertShader = compileShader(GL_VERTEX_SHADER, (GLchar*)vertexShader.UTF8String);
    NSAssert(vertShader != 0, @"compile vertex shader failed");
    
    fragShader = compileShader(GL_FRAGMENT_SHADER, (GLchar*)fragmentShader1.UTF8String);
    NSAssert(fragShader != 0, @"compile fragment shader failed");
    
    glAttachShader(_nv12Program, vertShader);
    glAttachShader(_nv12Program, fragShader);
    
    glLinkProgram(_nv12Program);
    
    _position = glGetAttribLocation(_nv12Program, "position");
    _textureCoord = glGetAttribLocation(_nv12Program, "texcoord");
    
    
    GLint status;
    glGetProgramiv(_nv12Program, GL_LINK_STATUS, &status);
    NSAssert(status == GL_TRUE, @"Failed to link program %d", _nv12Program);
    
    result = validateProgram(_nv12Program);
    NSAssert(result, @"etup GL programm failed");
    
    GLint ySampler = glGetUniformLocation(_nv12Program, "s_textureY");
    GLint uvSampler = glGetUniformLocation(_nv12Program, "s_textureUV");

    NSAssert(ySampler >= 0, @"Failed to get uniform variable locations in NV12 shader");
    NSAssert(uvSampler >= 0, @"Failed to get uniform variable locations in NV12 shader");

    glUseProgram(_nv12Program);
    glUniform1i(ySampler, kYTextureUnit);
    glUniform1i(uvSampler, kUvTextureUnit);
    
    
    glGenBuffers(1, &_vbo);
    glGenVertexArrays(1, &_vao);
    /// 左侧顶点坐标，右侧纹理坐标
    static const GLfloat vertices[] = {
        -1.0f, -1.0f,  0.0f, 1.0f,
         1.0f, -1.0f,  1.0f, 1.0f,
         1.0f,  1.0f,  1.0f, 0.0f,
        -1.0f,  1.0f,  0.0f, 0.0f,
    };
    glBindVertexArray(_vao);
    glBindBuffer(GL_ARRAY_BUFFER, _vbo);
    glBufferData(GL_ARRAY_BUFFER, 4 * 4 * sizeof(GLfloat), NULL, GL_STATIC_DRAW);
    glBufferSubData(GL_ARRAY_BUFFER, 0, sizeof(vertices), vertices);
    
    // 3. 设置顶点属性指针
    glVertexAttribPointer(_position, 2, GL_FLOAT, GL_FALSE, 4 * sizeof(GLfloat), (void*)0);
    glEnableVertexAttribArray(_position);
    
    glVertexAttribPointer(_textureCoord, 2, GL_FLOAT, GL_FALSE, 4 * sizeof(GLfloat), (void *)(2 * sizeof(GLfloat)));
    glEnableVertexAttribArray(_textureCoord);
    
    return result;
}

- (void)applyShadingForFrameWithWidth:(int)width
                               height:(int)height
                               yPlane:(GLuint)yPlane
                              uvPlane:(GLuint)uvPlane {
    if (!_nv12Program) {
        [self buildProgramWithVertextShader:vertexShader fragmentShader:fragmentShader];
        glUseProgram(_nv12Program);
        glBindVertexArray(_vao);
    }
    

    
    
    
    
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    glActiveTexture(static_cast<GLenum>(GL_TEXTURE0 + kYTextureUnit));
    glBindTexture(GL_TEXTURE_2D, yPlane);

    glActiveTexture(static_cast<GLenum>(GL_TEXTURE0 + kUvTextureUnit));
    glBindTexture(GL_TEXTURE_2D, uvPlane);

    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
    

}


@end
