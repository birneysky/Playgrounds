//
//  VideoViewShading.m
//  CameraOverCompositing
//
//  Created by Bruce on 2021/7/23.
//

#import "VideoViewShading.h"

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

NSString *const fragmentShader1 = SHADER_STRING
(
 varying highp vec2 v_texcoord;
 uniform sampler2D inputImageTexture;
 uniform lowp sampler2D s_textureY;
 uniform lowp sampler2D s_textureUV;
 void main() {

    mediump vec3 yuv;
    
    yuv.x = texture2D(s_textureY, v_texcoord).r;
    yuv.yz = texture2D(s_textureUV, v_texcoord).ra - vec2(0.5, 0.5);
    
    mediump mat3 matrix = mat3( 1.164,  1.164, 1.164,
                                0.0,   -0.213, 2.112,
                                1.793, -0.533, 0.0 );
    lowp vec3 rgb = matrix * yuv;
    gl_FragColor = vec4(rgb,1.0);
 }
);


NSString *const fragmentShader2 = SHADER_STRING
(
 varying highp vec2 v_texcoord;
 uniform sampler2D s_textureRGBA;
 uniform lowp sampler2D s_textureY;
 uniform lowp sampler2D s_textureUV;
 void main() {

    mediump vec3 yuv;
    
    yuv.x = texture2D(s_textureY, v_texcoord).r;
    yuv.yz = texture2D(s_textureUV, v_texcoord).ra - vec2(0.5, 0.5);
    
    mediump mat3 matrix = mat3( 1.164,  1.164, 1.164,
                                0.0,   -0.213, 2.112,
                                1.793, -0.533, 0.0 );
    lowp vec3 rgb = matrix * yuv;
    gl_FragColor = vec4(rgb,1.0);
 }
);
