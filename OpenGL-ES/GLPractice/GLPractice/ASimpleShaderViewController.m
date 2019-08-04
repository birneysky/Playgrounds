//
//  ASimpleShaderViewController.m
//  GLPractice
//
//  Created by birneysky on 2019/8/4.
//  Copyright © 2019 Grocery. All rights reserved.
//

#import "ASimpleShaderViewController.h"
#import "AGLKVertexAttributeArrayBuffer.h"
#import "AGLKContext.h"

@interface ASimpleShaderViewController ()

@property (nonatomic, strong) GLKBaseEffect* baseEffect;
@property (nonatomic, strong) AGLKVertexAttributeArrayBuffer* vertexBuffer;
@end

@implementation ASimpleShaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    GLKView* view = (GLKView*)self.view;
    NSAssert([view isKindOfClass:GLKView.class],
             @"View controller's view is a GLKView");
    
    view.context = [[AGLKContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:view.context];
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.light0.enabled = GL_TRUE;
    self.baseEffect.light0.diffuseColor = GLKVector4Make(
                                                         0.7f, // Red
                                                         0.7f, // Green
                                                         0.7f, // Blue
                                                         1.0f);// Alpha
    
    glEnable(GL_DEPTH_TEST);
    
    
    // Set the background color stored in the current context
    ((AGLKContext *)view.context).clearColor = GLKVector4Make(
                                                              0.f, // Red
                                                              0.f, // Green
                                                              0.f, // Blue
                                                              1.0f);// Alpha
    
    // Setup texture0
    CGImageRef imageRef0 =
    [[UIImage imageNamed:@"bug.png"] CGImage];
    
    GLKTextureInfo *textureInfo0 = [GLKTextureLoader
                                    textureWithCGImage:imageRef0
                                    options:[NSDictionary dictionaryWithObjectsAndKeys:
                                             [NSNumber numberWithBool:YES],
                                             GLKTextureLoaderOriginBottomLeft, nil]
                                    error:NULL];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [self.baseEffect prepareToDraw];
    [(AGLKContext *)view.context clear:GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT];
}

@end
