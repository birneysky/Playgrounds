//
//  ALighting ViewController.m
//  GLPractice
//
//  Created by birneysky on 2019/8/6.
//  Copyright © 2019 Grocery. All rights reserved.
//

#import "ALightingViewController.h"
#import "SceneVertex.h"
#import "AGLKContext.h"
#import "AGLKVertexAttributeArrayBuffer.h"

/**
              Y  1
               |
               |
               |
               |
               |
               |
 <-------------------- |-----------------------> X
 -1                            |                                    1
               |
               |
               |
               |
               |
              Y -1
 
 
              Y  1
               |
               |
        A             | D             G
        ●             ●                ●
               |
               |                    H
 <----------●---------●E----------●-------------> X
 -1             B            |                                    1
               |
        ●             ●F               ● I
        C             |
               |
               |
              Y -1
 */
NormalVertex vertexA = {{-0.5,  0.5,  -0.5}, {0.0, 0.0, 1.0}};
NormalVertex vertexB = {{-0.5,  0.0,  -0.5}, {0.0, 0.0, 1.0}};
NormalVertex vertexC = {{-0.5, -0.5,  -0.5}, {0.0, 0.0, 1.0}};
NormalVertex vertexD = {{ 0.0,  0.5,  -0.5}, {0.0, 0.0, 1.0}};
NormalVertex vertexE = {{ 0.0,  0.0,   0.0}, {0.0, 0.0, 1.0}};
NormalVertex vertexF = {{ 0.0, -0.5,  -0.5}, {0.0, 0.0, 1.0}};
NormalVertex vertexG = {{ 0.5,  0.5,  -0.5}, {0.0, 0.0, 1.0}};
NormalVertex vertexH = {{ 0.5,  0.0,  -0.5}, {0.0, 0.0, 1.0}};
NormalVertex vertexI = {{ 0.5, -0.5,  -0.5}, {0.0, 0.0, 1.0}};



@interface ALightingViewController ()

@property (nonatomic, strong) GLKBaseEffect* baseEffect;
@property (nonatomic, strong) GLKBaseEffect* extraEffect;
@property (nonatomic, strong) AGLKVertexAttributeArrayBuffer* vertexBuffer;
@end

const int NUM_FACES = 8;

@implementation ALightingViewController {
    NormalTriangle triangles[NUM_FACES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    GLKView* view = (GLKView*)self.view;
    view.context = [[AGLKContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [AGLKContext setCurrentContext:view.context];
    ((AGLKContext*)view.context).clearColor =
        GLKVector4Make(0.0f,
                       0.0f,
                       0.0f,
                       1.0f);
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.light0.enabled = GL_TRUE;
    self.baseEffect.light0.diffuseColor =
        GLKVector4Make(0.7f, /// red
                       0.7f, /// green
                       0.7f, /// blue
                       1.0f);/// alpha
    self.baseEffect.light0.position =
        GLKVector4Make(1.0f, 1.0f, 0.5f, 0.0f);
    
    
    self.extraEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor =
        GLKVector4Make(0.0, /// red
                       1.0f, /// green
                       0.0f,
                       1.0f);
    
    GLKMatrix4 modelViewMatrix =
        GLKMatrix4MakeRotation(GLKMathDegreesToRadians(-60.0f),
                               1.0f,
                               0.0f,
                               0.0f);
    
    modelViewMatrix =
        GLKMatrix4Rotate(modelViewMatrix,
                         GLKMathDegreesToRadians(-30.0f),
                         0.0f,
                         0.0f,
                         1.0f);
    
    modelViewMatrix = GLKMatrix4Translate(modelViewMatrix, 0.0f, 0.0f, 0.25f);
    
    self.baseEffect.transform.modelviewMatrix = modelViewMatrix;
    self.extraEffect.transform.modelviewMatrix = modelViewMatrix;
    
    triangles[0] = normalTriangleMake(vertexA, vertexB, vertexD);
    triangles[1] = normalTriangleMake(vertexB, vertexC, vertexF);
    triangles[2] = normalTriangleMake(vertexD, vertexB, vertexE);
    triangles[3] = normalTriangleMake(vertexE, vertexB, vertexF);
    triangles[4] = normalTriangleMake(vertexD, vertexE, vertexH);
    triangles[5] = normalTriangleMake(vertexE, vertexF, vertexH);
    triangles[6] = normalTriangleMake(vertexG, vertexD, vertexH);
    triangles[7] = normalTriangleMake(vertexH, vertexF, vertexI);
    
    self.vertexBuffer = [[AGLKVertexAttributeArrayBuffer alloc] initWithAttributeStride:sizeof(NormalVertex) numberOfVertices:sizeof(triangles)/sizeof(NormalVertex) data:triangles usage:GL_DYNAMIC_DRAW];
    
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [self.baseEffect prepareToDraw];
    
    [((AGLKContext*)view.context) clear:GL_COLOR_BUFFER_BIT];
    
    [self.vertexBuffer prepareToDrawWithAttrib:GLKVertexAttribPosition numberOfCoordinates:3 attributeOffset:offsetof(NormalVertex, position) shouldEnable:YES];
    [self.vertexBuffer prepareToDrawWithAttrib:GLKVertexAttribNormal numberOfCoordinates:3 attributeOffset:offsetof(NormalVertex, normal) shouldEnable:YES];
    
    [self.vertexBuffer drawArrayWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:sizeof(triangles)/sizeof(NormalVertex)];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
