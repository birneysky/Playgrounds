//
//  ShadingHelper.h
//  CameraOverCompositing
//
//  Created by Bruce on 2021/7/22.
//

#ifndef ShadingHelper_h
#define ShadingHelper_h

#include <stdbool.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <OpenGLES/gltypes.h>

#ifdef __cplusplus
extern "C" {
#endif

GLuint compileShader(GLenum type, GLchar* shaderString);

bool validateProgram(GLuint prog);

#ifdef __cplusplus
}
#endif

#endif /* ShadingHelper_h */
