//
//  NV12Shader.m
//  CameraOverCompositing
//
//  Created by Bruce on 2021/7/20.
//

#import "NV12Shader.h"
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>


#define STRINGIZE(x) #x
#define STRINGIZE2(x) STRINGIZE(x)
#define SHADER_STRING(text) @ STRINGIZE2(text)

NSString *const vertexShader = SHADER_STRING
(
 attribute vec4 position;
 attribute vec2 texcoord;
 varying vec2 v_texcoord;
 
 void main()
 {
     gl_Position = position;
     v_texcoord = texcoord.xy;
 }
);

NSString *const fragmentShader = SHADER_STRING
(
 varying highp vec2 v_texcoord;
 uniform sampler2D inputImageTexture;
 uniform lowp sampler2D s_textureY;
 uniform lowp sampler2D s_textureUV;
 void main() {
    mediump float y;
    mediump vec2 uv;
    y = texture2D(s_textureY, v_texcoord).r;
    uv = texture2D(s_textureUV, v_texcoord).ra - vec2(0.5, 0.5);
    gl_FragColor = vec4(y + 1.403 * uv.y,
                        y - 0.344 * uv.x - 0.714 * uv.y,
                        y + 1.770 * uv.x,
                        1.0);
 }
);


static inline GLuint compileShader(GLenum type, NSString *shaderString) {
    GLint status;
    const GLchar *sources = (GLchar *)shaderString.UTF8String;
    
    GLuint shader = glCreateShader(type);
    if (shader == 0 || shader == GL_INVALID_ENUM) {
        NSLog(@"Failed to create shader %d", type);
        return 0;
    }
    
    glShaderSource(shader, 1, &sources, NULL);
    glCompileShader(shader);
    
#ifdef DEBUG
    GLint logLength;
    glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
    
    glGetShaderiv(shader, GL_COMPILE_STATUS, &status);
    if (status == GL_FALSE) {
        glDeleteShader(shader);
        NSLog(@"Failed to compile shader:\n");
        return 0;
    }
    
    return shader;
}

static inline BOOL validateProgram(GLuint prog) {
    GLint status;
    
    glValidateProgram(prog);
    
#ifdef DEBUG
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
#endif
    
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == GL_FALSE) {
        NSLog(@"Failed to validate program %d", prog);
        return NO;
    }
    
    return YES;
}

@implementation NV12Shader {
    GLuint _nv12Program;
    GLint  _position;
    GLint _textureCoord;
    GLint _InputTextureUniform;
}

- (BOOL)buildProgramWithVertextShader:(NSString*)vertexShader
                       fragmentShader:(NSString*) fragmentShader {
    BOOL result = NO;
    GLuint vertShader = 0, fragShader = 0;
    _nv12Program = glCreateProgram();
    vertShader = compileShader(GL_VERTEX_SHADER, vertexShader);
    if (!vertShader)
        goto exit;
    fragShader = compileShader(GL_FRAGMENT_SHADER, fragmentShader);
    if (!fragShader)
        goto exit;
    
    glAttachShader(_nv12Program, vertShader);
    glAttachShader(_nv12Program, fragShader);
    
    glLinkProgram(_nv12Program);
    
    _position = glGetAttribLocation(_nv12Program, "position");
    _textureCoord = glGetAttribLocation(_nv12Program, "texcoord");
    
    GLint status;
    glGetProgramiv(_nv12Program, GL_LINK_STATUS, &status);
    if (status == GL_FALSE) {
        NSLog(@"Failed to link program %d", _nv12Program);
        goto exit;
    }
    result = validateProgram(_nv12Program);
exit:
    if (vertShader)
        glDeleteShader(vertShader);
    if (fragShader)
        glDeleteShader(fragShader);
    
    if (result) {
        NSLog(@"OK setup GL programm");
    } else {
        glDeleteProgram(_nv12Program);
        _nv12Program = 0;
    }
    return result;
}

- (void)applyShadingForFrameWithWidth:(int)width
                               height:(int)height
                               yPlane:(GLuint)yPlane
                              uvPlane:(GLuint)uvPlane {
    static const GLfloat imageVertices[] = {
        -1.0f, -1.0f,
        1.0f, -1.0f,
        -1.0f,  1.0f,
        1.0f,  1.0f,
    };
    
    GLfloat noRotationTextureCoordinates[] = {
        0.0f, 1.0f,
        1.0f, 1.0f,
        0.0f, 0.0f,
        1.0f, 0.0f,
    };
    
    glVertexAttribPointer(_position, 2, GL_FLOAT, 0, 0, imageVertices);
    glEnableVertexAttribArray(_position);
    glVertexAttribPointer(_textureCoord, 2, GL_FLOAT, 0, 0, noRotationTextureCoordinates);
    glEnableVertexAttribArray(_textureCoord);
    
    if (!_nv12Program) {
        [self buildProgramWithVertextShader:vertexShader fragmentShader:fragmentShader];
    }
}

@end
