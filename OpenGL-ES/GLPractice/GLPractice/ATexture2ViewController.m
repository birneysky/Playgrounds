//
//  ATexture2ViewController.m
//  GLPractice
//
//  Created by birney on 2019/7/26.
//  Copyright © 2019 Grocery. All rights reserved.
//

#import "ATexture2ViewController.h"
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

static  TextureVertex vertices[]  = {
    {{-0.5f, -0.5f, 0.0f},{0.0f, 0.0f}},
    {{0.5f, -0.5f, 0.0f},{1.0f, 0.0f}},
    {{-0.5f, 0.5f, 0.0f},{0.0f, 1.0f}}
};


static const TextureVertex defaultVertices[] = {
   {{-0.5f, -0.5f, 0.0f}, {0.0f, 0.0f}},
   {{ 0.5f, -0.5f, 0.0f}, {1.0f, 0.0f}},
   {{-0.5f,  0.5f, 0.0f}, {0.0f, 1.0f}},
};

static GLKVector3 movementVectors[3] = {
   {-0.02f,  -0.01f, 0.0f},
   {0.01f,  -0.005f, 0.0f},
   {-0.01f,   0.01f, 0.0f},
};

@interface GLKEffectPropertyTexture (AGLKAdditions)

- (void)aglkSetParameter:(GLenum)parameterID
                   value:(GLint)value;

@end

@implementation GLKEffectPropertyTexture (AGLKAdditions)

- (void)aglkSetParameter:(GLenum)parameterID
                   value:(GLint)value {
    glBindTexture(self.target, self.name);
    
    glTexParameteri(self.target,
                    parameterID,
                    value);
}


@end;

@interface ATexture2ViewController ()

@property (nonatomic, strong) GLKBaseEffect* baseEffect;
@property (nonatomic, strong) AGLKVertexAttributeArrayBuffer* vertexBuffer;
@property (nonatomic, assign) BOOL shouldAnimate;
@property (nonatomic, assign) BOOL shouldRepeatTexture;
@property (nonatomic, assign) BOOL shouldUseLinearFilter;
@property (nonatomic, assign) float coordinateOffset;
@end

@implementation ATexture2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    GLKView* view = (GLKView*)self.view;
    NSAssert([view isKindOfClass:GLKView.class],
             @"view controller's view is not a GLKView");
    
    self.preferredFramesPerSecond = 60;
    self.shouldAnimate = YES;
    self.shouldRepeatTexture = YES;
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
     initWithAttributeStride:sizeof(TextureVertex)
     numberOfVertices:sizeof(vertices)/sizeof(TextureVertex)
     data:vertices
     usage:GL_STATIC_DRAW];
    
    
    CGImageRef imgRef =  [UIImage imageNamed:@"grid"].CGImage;
    
    GLKTextureInfo* textureInfo =
    [GLKTextureLoader textureWithCGImage:imgRef
                                 options:nil
                                   error:nil];
    
    self.baseEffect.texture2d0.name = textureInfo.name;
    self.baseEffect.texture2d0.target = textureInfo.target;

}

- (void)update {
    [self updateAnimatedVertexPositions2];
    [self updateTextureParameters];
    
    [self.vertexBuffer reinitWithAttribStride:sizeof(TextureVertex)
                        numberOfVertices:sizeof(vertices) / sizeof(TextureVertex)
                                   bytes:vertices];
}

- (void)dealloc {
    [AGLKContext setCurrentContext:nil];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [self.baseEffect prepareToDraw];
    [(AGLKContext*)view.context clear:GL_COLOR_BUFFER_BIT];
    
    /// offsetof(Vertex, postionCoords) 意思是成员变量postionCoords距离Vertex首地址偏移的字节数
    [self.vertexBuffer prepareToDrawWithAttrib:GLKVertexAttribPosition
                           numberOfCoordinates:3
                               attributeOffset:offsetof(TextureVertex, positionCoords)
                                  shouldEnable:YES];
    
    [self.vertexBuffer prepareToDrawWithAttrib:GLKVertexAttribTexCoord0
                           numberOfCoordinates:2
                               attributeOffset:offsetof(TextureVertex, textureCoords)
                                  shouldEnable:YES];
    
    [self.vertexBuffer drawArrayWithMode:GL_TRIANGLES
                        startVertexIndex:0
                        numberOfVertices:3];
}

#pragma mark - Helper
- (void)updateAnimatedVertexPositions {
    if (self.shouldAnimate) {
        for (int i = 0; i < sizeof(vertices) / sizeof(TextureVertex); i++) {
            vertices[i].positionCoords.x += movementVectors[i].x;
            if (vertices[i].positionCoords.x >= 1.0f ||
                vertices[i].positionCoords.x <= -1.0f) {
                vertices[i].positionCoords.x -= movementVectors[i].x;
            }
            
            vertices[i].positionCoords.y += movementVectors[i].y;
            if (vertices[i].positionCoords.y >= 1.0f ||
                vertices[i].positionCoords.y <= -1.0f) {
                vertices[i].positionCoords.y -= movementVectors[i].y;
            }
            
            vertices[i].positionCoords.z += movementVectors[i].z;
            if (vertices[i].positionCoords.z >= 1.0f &&
                vertices[i].positionCoords.z <= -1.0f) {
                vertices[i].positionCoords.z -= movementVectors[i].z;
            }
        }
    } else {
        for (int i = 0; i < sizeof(vertices) / sizeof(TextureVertex); i++) {
            vertices[i].positionCoords.x = defaultVertices[i].positionCoords.x;
            vertices[i].positionCoords.y = defaultVertices[i].positionCoords.y;
            vertices[i].positionCoords.z = defaultVertices[i].positionCoords.z;
        }
    }
    
    for (int i = 0; i < sizeof(vertices) / sizeof(TextureVertex); i++) {
        vertices[i].textureCoords.s = defaultVertices[i].textureCoords.s + self.coordinateOffset;
    }
    
    for (int i = 0; i < 1; i++) {
        NSLog(@"i:%d x = %f, y= %f, z = %f",i,vertices[i].positionCoords.x, vertices[i].positionCoords.y,vertices[i].positionCoords.z);
    }
}



- (void)updateAnimatedVertexPositions2 {
    if (self.shouldAnimate) {
        //// 让 x y z 的值在[-1,1]区间内滑动
        for (int i = 0; i < sizeof(vertices) / sizeof(TextureVertex); i++) {
            vertices[i].positionCoords.x += movementVectors[i].x;
            if  (vertices[i].positionCoords.x >= 1.0f ||
                vertices[i].positionCoords.x <= -1.0f) {
                vertices[i].positionCoords.x -= movementVectors[i].x;
                movementVectors[i].x = -movementVectors[i].x;
            }
            
            vertices[i].positionCoords.y += movementVectors[i].y;
            if (vertices[i].positionCoords.y >= 1.0f ||
                vertices[i].positionCoords.y <= -1.0f) {
                vertices[i].positionCoords.y -= movementVectors[i].y;
                movementVectors[i].y = -movementVectors[i].y;
            }
        
            vertices[i].positionCoords.z += movementVectors[i].z;
            if (vertices[i].positionCoords.z >= 1.0f &&
                vertices[i].positionCoords.z <= -1.0f) {
                vertices[i].positionCoords.z -= movementVectors[i].z;
                movementVectors[i].z = -movementVectors[i].z;
            }
        }
    } else {
        for (int i = 0; i < sizeof(vertices) / sizeof(TextureVertex); i++) {
            vertices[i].positionCoords.x = defaultVertices[i].positionCoords.x;
            vertices[i].positionCoords.y = defaultVertices[i].positionCoords.y;
            vertices[i].positionCoords.z = defaultVertices[i].positionCoords.z;
        }
    }
    
    for (int i = 0; i < sizeof(vertices) / sizeof(TextureVertex); i++) {
        vertices[i].textureCoords.s = defaultVertices[i].textureCoords.s + self.coordinateOffset;
    }
    
    for (int i = 0; i < 3; i++) {
        NSLog(@"i:%d x = %f, y= %f, z = %f",i,vertices[i].positionCoords.x, vertices[i].positionCoords.y,vertices[i].positionCoords.z);
    }
}

- (void)updateTextureParameters
{
    [self.baseEffect.texture2d0
     aglkSetParameter:GL_TEXTURE_WRAP_S
     value:(self.shouldRepeatTexture ?
            GL_REPEAT : GL_CLAMP_TO_EDGE)];
    
    [self.baseEffect.texture2d0
     aglkSetParameter:GL_TEXTURE_MAG_FILTER
     value:(self.shouldUseLinearFilter ?
            GL_LINEAR : GL_NEAREST)];
}


#pragma mark - Target action

- (IBAction)coordinateDidChange:(UISlider *)sender {
    self.coordinateOffset = sender.value;
}

- (IBAction)repeatTextureAction:(UISwitch *)sender {
    self.shouldRepeatTexture = sender.isOn;
}

- (IBAction)userLinearFilterAction:(UISwitch*)sender {
    self.shouldUseLinearFilter = sender.isOn;
}

@end
