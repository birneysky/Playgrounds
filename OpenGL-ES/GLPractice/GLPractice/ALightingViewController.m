//
//  ALighting ViewController.m
//  GLPractice
//
//  Created by birneysky on 2019/8/6.
//  Copyright © 2019 Grocery. All rights reserved.
//

#import "ALightingViewController.h"
#import "SceneVertex.h"


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

typedef struct {
    NormalVertex vertices[3];
} Triangle;

@interface ALightingViewController ()

@property (nonatomic, strong) GLKBaseEffect* baseEffect;
@end


@implementation ALightingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GLKView* view = (GLKView*)self.view;
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:view.context];
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.light0.enabled = GL_TRUE;
    self.baseEffect.light0.diffuseColor = GLKVector4Make(0.7f, /// red
                                                         0.7f, /// gree
                                                         0.7f, /// blue
                                                         1.0f);/// alpha
    self.baseEffect.light0.position = GLKVector4Make(1.0f, 1.0f, 0.5f, 0.0f);
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
