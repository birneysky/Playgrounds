//
//  NV12Shader.m
//  CameraOverCompositing
//
//  Created by Bruce on 2021/7/20.
//

#import "NV12Shader.h"
#include "ShadingHelper.h"

#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/ES3/glext.h>
#import <OpenGLES/gltypes.h>

static const int kYTextureUnit = 0;
static const int kUvTextureUnit = 1;

@implementation NV12Shader {
    GLuint _nv12Program;
    GLint  _position;
    GLint _textureCoord;
    GLint _InputTextureUniform;
}

- (void)dealloc {
    glDeleteProgram(_nv12Program);
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

    return result;
}

- (void)applyShadingForFrameWithWidth:(int)width
                               height:(int)height
                               yPlane:(GLuint)yPlane
                              uvPlane:(GLuint)uvPlane {
    if (!_nv12Program) {
        [self buildProgramWithVertextShader:vertexShader fragmentShader:fragmentShader];
    }
    
    static const GLfloat imageVertices[] = {
        -1.0f, -1.0f,
        1.0f, -1.0f,
        1.0f,  1.0f,
        -1.0f,  1.0f,
    };
    
    GLfloat noRotationTextureCoordinates[] = {
        0.0f, 1.0f,
        1.0f, 1.0f,
        1.0f, 0.0f,
        0.0f, 0.0f,
    };
    
    glVertexAttribPointer(_position, 2, GL_FLOAT, 0, 0, imageVertices);
    glEnableVertexAttribArray(_position);
    glVertexAttribPointer(_textureCoord, 2, GL_FLOAT, 0, 0, noRotationTextureCoordinates);
    glEnableVertexAttribArray(_textureCoord);

    glUseProgram(_nv12Program);
    
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

- (void)applyShadingForFrameWithWidth:(int)width
                               height:(int)height
                           textureIds:(GLuint*)tids
                               length:(int)len {
    if (!_nv12Program) {
        [self buildProgramWithVertextShader:vertexShader fragmentShader:fragmentShader];
    }

    static const GLfloat imageVertices[] = {
        -1.0f, -1.0f,
        1.0f, -1.0f,
        1.0f,  1.0f,
        -1.0f,  1.0f,
    };

    GLfloat noRotationTextureCoordinates[] = {
        0.0f, 1.0f,
        1.0f, 1.0f,
        1.0f, 0.0f,
        0.0f, 0.0f,
    };

    glVertexAttribPointer(_position, 2, GL_FLOAT, 0, 0, imageVertices);
    glEnableVertexAttribArray(_position);
    glVertexAttribPointer(_textureCoord, 2, GL_FLOAT, 0, 0, noRotationTextureCoordinates);
    glEnableVertexAttribArray(_textureCoord);

    glUseProgram(_nv12Program);

    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    
    for (int i = 0; i < len; i++) {
        glActiveTexture(static_cast<GLenum>(GL_TEXTURE0 + i));
        glBindTexture(GL_TEXTURE_2D, tids[i]);
    }

    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
                                   
}


@end
