//
//  ATextureBlendViewController.m
//  GLPractice
//
//  Created by birneysky on 2019/7/29.
//  Copyright © 2019 Grocery. All rights reserved.
//

#import "ATextureBlendViewController.h"
#import "AGLKVertexAttributeArrayBuffer.h"
#import "SceneVertex.h"
#import "AGLKContext.h"
#import "AGLKTextureInfo.h"

/**
 
               Y  1
               |
(-1.0,0.67)                 |                             (1.0,0.67)
  ●                           |                               ●
               |
               |
               |
 <-------------------- |-----------------------> X
 -1                            |                                    1
               |
               |
  ●                           |                                ●
(-1.0,-0.67)                |                               (1.0,-0.67)
               |
               Y -1
 
 (0,1)
T|●                                                             ● (1,1)
 |
 |
 |
 |
 |
 |
 |
 |
 |
 ●--------------------------------------------●> S
 (0,0)                                                         (1,0)
 */


static TextureVertex vertices[] =  {
    {{-1.0f, -0.67f, 0.0f}, {0.0f, 0.0f}},  // first triangle
    {{ 1.0f, -0.67f, 0.0f}, {1.0f, 0.0f}},
    {{-1.0f,  0.67f, 0.0f}, {0.0f, 1.0f}},
    {{ 1.0f, -0.67f, 0.0f}, {1.0f, 0.0f}},  // second triangle
    {{-1.0f,  0.67f, 0.0f}, {0.0f, 1.0f}},
    {{ 1.0f,  0.67f, 0.0f}, {1.0f, 1.0f}},
};

@interface ATextureBlendViewController ()

@property (nonatomic, strong) GLKBaseEffect* baseEffect;
@property (nonatomic, strong) AGLKVertexAttributeArrayBuffer* vertexBuffer;
@property (nonatomic, strong) AGLKTextureInfo* textureInfo0;
@property (nonatomic, strong) AGLKTextureInfo* textureInfo1;
@end

@implementation ATextureBlendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    GLKView* view = (GLKView*)self.view;
    NSAssert([view isKindOfClass:GLKView.class],
             @"view controller's view is not GLKView");
    view.context = [[AGLKContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:view.context];
    
    // Set the background color stored in the current context
    ((AGLKContext *)view.context).clearColor = GLKVector4Make(0.0f, // Red
                                                              0.0f, // Green
                                                              0.0f, // Blue
                                                              1.0f);// Alpha
    
    
    // Enable fragment blending with Frame Buffer contents
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
}


#pragma mark - getters
- (GLKBaseEffect*)baseEffect {
    if (!_baseEffect) {
        _baseEffect = [[GLKBaseEffect alloc] init];
        _baseEffect.useConstantColor = GL_TRUE;
        _baseEffect.constantColor = GLKVector4Make(1.0f,///red
                                                   1.0f,///green
                                                   1.0f,///blue
                                                   1.0f);/// alpha
    }
    return _baseEffect;
}

- (AGLKVertexAttributeArrayBuffer*)vertexBuffer {
    if (!_vertexBuffer) {
        _vertexBuffer = [[AGLKVertexAttributeArrayBuffer alloc]
                          initWithAttributeStride:sizeof(TextureVertex)
                          numberOfVertices:sizeof(vertices)/sizeof(TextureVertex)
                          data:vertices
                          usage:GL_STATIC_DRAW];
    }
    return _vertexBuffer;
}

- (AGLKTextureInfo*)textureInfo0 {
    if (!_textureInfo0) {
        CGImageRef beetleImg = [UIImage imageNamed:@"beetle"].CGImage;
        _textureInfo0 = [GLKTextureLoader textureWithCGImage:beetleImg
                                                     options:nil//@{GLKTextureLoaderOriginBottomLeft:@(YES)}
                                                       error:nil];
    }
    return _textureInfo0;
}

- (AGLKTextureInfo*)textureInfo1 {
    if (!_textureInfo1) {
        CGImageRef leaf = [UIImage imageNamed:@"leaf"].CGImage;
        _textureInfo1 = [AGLKTextureInfo textureWithCGImage:leaf
                                                     options:@{GLKTextureLoaderOriginBottomLeft:@(YES)}
                                                       error:nil];
    }
    return _textureInfo1;
}


- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [self.baseEffect prepareToDraw];
    [(AGLKContext *)view.context clear:GL_COLOR_BUFFER_BIT];
    [self.vertexBuffer prepareToDrawWithAttrib:GLKVertexAttribPosition
                           numberOfCoordinates:3
                               attributeOffset:offsetof(TextureVertex, positionCoords)
                                  shouldEnable:YES];
    
    [self.vertexBuffer prepareToDrawWithAttrib:GLKVertexAttribTexCoord0
                           numberOfCoordinates:2
                               attributeOffset:offsetof(TextureVertex, textureCoords)
                                  shouldEnable:YES];
    
    self.baseEffect.texture2d0.name = self.textureInfo1.name;
    self.baseEffect.texture2d0.target = self.textureInfo1.target;
    [self.baseEffect prepareToDraw];
    


    
    // Draw triangles using the vertices in the
    // currently bound vertex buffer
    [self.vertexBuffer drawArrayWithMode:GL_TRIANGLES
                        startVertexIndex:0
                        numberOfVertices:sizeof(vertices) / sizeof(TextureVertex)];

    self.baseEffect.texture2d0.name = self.textureInfo0.name;
    self.baseEffect.texture2d0.target = self.textureInfo0.target;
    [self.baseEffect prepareToDraw];

    
    // Draw triangles using currently bound vertex buffer
    [self.vertexBuffer drawArrayWithMode:GL_TRIANGLES
                        startVertexIndex:0
                        numberOfVertices:sizeof(vertices) / sizeof(TextureVertex)];
}


@end
