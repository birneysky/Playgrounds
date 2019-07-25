//
//  ATextureViewController.m
//  GLPractice
//
//  Created by birneysky on 2019/7/25.
//  Copyright © 2019 Grocery. All rights reserved.
//

#import "ATextureViewController.h"
#import "SceneVertex.h"
#import "AGLKContext.h"
#import "AGLKVertexAttributeArrayBuffer.h"

/**
 
               Y  1
               |
               |
        ●             |
               |
               |
               |
 <-------------------- |-----------------------> X
 -1                            |                                    1
               |
        ●             |                  ●
    (-0.5,-0.5)         |              (0.5,-0.5)
               |
               |
              Y -1

 (0,1)
T  |                                                             ● (1,1)
  |
  |
  |
  |
  |
  |
  |
  |
  |
  |--------------------------------------------> S
  (0,0)                                                         (1,0)
 */

static const Vertex vertices[]  = {
    {{-0.5f, -0.5f, 0.0f},{0.0f, 0.0f}},
    {{0.5f, -0.5f, 0.0f},{1.0f, 0.0f}},
    {{-0.5f, 0.5f, 0.0f},{0.0f, 1.0f}}
};

@interface ATextureViewController ()

@property (nonatomic, strong) GLKBaseEffect* baseEffect;
@property (nonatomic, strong) AGLKVertexAttributeArrayBuffer* vertexBuffer;
@end

@implementation ATextureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GLKView* view = (GLKView*)self.view;
    NSAssert([view isKindOfClass:GLKView.class],
             @"view controller's view is not a GLKView");
    
    view.context = [[AGLKContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    [AGLKContext setCurrentContext:view.context];
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor = GLKVector4Make(1.0f, /// red
                                                   1.0f, /// green
                                                   0.5f, /// blue
                                                   1.0f); /// alpha
    ((AGLKContext*)view.context).clearColor = GLKVector4Make(0.0f, /// red
                                                             0.0f, /// green
                                                             0.0f, /// blue
                                                             1.0f); /// alpha
    
    self.vertexBuffer =
        [[AGLKVertexAttributeArrayBuffer alloc]
         initWithAttributeStride:sizeof(Vertex)
                numberOfVertices:sizeof(vertices)/sizeof(Vertex)
                            data:vertices
                           usage:GL_STATIC_DRAW];
    
    
    CGImageRef imgRef =  [UIImage imageNamed:@"flowers"].CGImage;
    
    GLKTextureInfo* textureInfo =
        [GLKTextureLoader textureWithCGImage:imgRef
                                     options:nil
                                       error:nil];
    
    self.baseEffect.texture2d0.name = textureInfo.name;
    self.baseEffect.texture2d0.target = textureInfo.target;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [self.baseEffect prepareToDraw];
    [(AGLKContext*)view.context clear:GL_COLOR_BUFFER_BIT];
    
    [self.vertexBuffer prepareToDrawWithAttrib:GLKVertexAttribPosition numberOfCoordinates:3 attributeOffset:offsetof(Vertex, postionCoords) shouldEnable:YES];
    
    [self.vertexBuffer prepareToDrawWithAttrib:GLKVertexAttribTexCoord0 numberOfCoordinates:2 attributeOffset:offsetof(Vertex, textureCoords) shouldEnable:YES];
    
    [self.vertexBuffer drawArrayWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:3];
}

@end
