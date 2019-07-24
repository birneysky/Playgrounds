//
//  ViewController.m
//  GLPractice
//
//  Created by birneysky on 2019/7/23.
//  Copyright © 2019 Grocery. All rights reserved.
//

#import "BasicViewController.h"
#import "SceneVertex.h"
#import <GLKit/GLKit.h>

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
       (-0.5,-0.5)      |                 (0.5,-0.5)
                 |
                 |
                 Y -1
 */

static const SceneVertex vertices[] = {
    {-0.5f, -0.5f, 0.0}, /// 左下角
    {0.5f, -0.5f, 0.0}, /// 右下角
    {-0.5f, 0.5f, 0.0}  /// 左上角
};

@interface BasicViewController ()<GLKViewDelegate>

@property(nonatomic, strong) GLKBaseEffect* baseEffect;

@end

@implementation BasicViewController {
    GLuint vertextBufferId;
}

- (void)dealloc {
    if (0 != vertextBufferId) {
        glDeleteBuffers(1, &vertextBufferId);
        vertextBufferId = 0;
    }
    [EAGLContext setCurrentContext:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSAssert([self.view isKindOfClass:GLKView.class], @"viewController's rootview is not a GLKView");
    GLKView* view = (GLKView*)self.view;
    view.delegate = self;
    /// 创建新的上下文对象
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    /// 设置新的当前上下文
    [EAGLContext setCurrentContext:view.context];
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor = GLKVector4Make(1.0f, /// red
                                                   1.0f, /// green
                                                   0.5f, /// blue
                                                   1.0f); /// alpha
    /// 设置背景色 当当前上下文中
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    
    /// 生成缓存
    glGenBuffers(1, &vertextBufferId);
    /// 绑定缓存
    glBindBuffer(GL_ARRAY_BUFFER, vertextBufferId);
    /// 初始化缓存，复制数据至缓存中
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
}


#pragma mark - GLKViewDelegate
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [self.baseEffect prepareToDraw];
    
    glClear(GL_COLOR_BUFFER_BIT);
    /// 启动顶点缓存渲染操作
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    
    /// 告诉opengl 顶点数据在哪里，以及怎么解释每个顶点保存的数据
    glVertexAttribPointer(GLKVertexAttribPosition,  /// 当前绑定的缓存包含每个顶点的位置信息
                          3,  /// 每个顶点有三个分量
                          GL_FLOAT,/// 每个分量是浮点类型的数
                          GL_FALSE, /// 小数点固定数据是否可以被改变
                          sizeof(SceneVertex), ///每个顶点的字节数
                          nil); /// nil 表示从绑定的顶点缓存的开始位置访问顶点数据
    
    /// 执行绘图
    glDrawArrays(GL_TRIANGLES, /// 告诉GPU怎么处理绑定的顶点缓存内的顶点数据
                 0, /// 第一个顶点的位置
                 3); /// 需要渲染的顶点数量
}

@end
