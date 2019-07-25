//
//  AGLKViewController.m
//  GLPractice
//
//  Created by birney on 2019/7/24.
//  Copyright © 2019 Grocery. All rights reserved.
//

#import "AGLKViewController.h"
#import "AGLKView.h"
#import "SceneVertex.h"
#import <GLKit/GLKit.h>

const NSInteger kAGLKDefaultFramesPerSecond = 30;

static const SceneVertex vertices[] = {
    {-0.5f, -0.5f, 0.0},
    {0.5f, -0.5f, 0.0},
    {-0.5f, 0.5f, 0.0},
    {0.5f, 0.0f, 0.0},
    {0.5f, 0.5f, 0.0},
    {0.0f, 0.5f, 0.0}
};

@interface AGLKViewController () <AGLKViewDelegate>

@property (nonatomic, strong) CADisplayLink* displayLink;
@property (nonatomic, assign) NSInteger preferredFramesPerSecond;
@property (nonatomic, assign, getter=isPaused) BOOL paused;
@property (nonatomic, strong) GLKBaseEffect* baseEffect;
@end

@implementation AGLKViewController {
    GLuint vertextBufferId;
}

- (void)dealloc {
    if (0 != vertextBufferId) {
        glDeleteBuffers(1, &vertextBufferId);
        vertextBufferId = 0;
    }
    [EAGLContext setCurrentContext:nil];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.preferredFramesPerSecond = kAGLKDefaultFramesPerSecond;
        self.paused = NO;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.preferredFramesPerSecond = kAGLKDefaultFramesPerSecond;
        self.paused = NO;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    AGLKView* glkView = (AGLKView*)self.view;
    NSAssert([glkView isKindOfClass:AGLKView.class], @"View controller's view is not a AGLKView");
    glkView.opaque = YES;
    glkView.delegate  = self;
    glkView.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor = GLKVector4Make(1.0f, /// red
                                                   0.5f, /// green
                                                   0.5f, /// blue
                                                   1.0f); /// alpha
    /// 设置背景色 当当前上下文中
    //glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    
    /// 生成缓存
    glGenBuffers(1, &vertextBufferId);
    /// 绑定缓存
    glBindBuffer(GL_ARRAY_BUFFER, vertextBufferId);
    /// 初始化缓存，复制数据至缓存中
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.opaque = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.view.opaque = YES;
}

- (void)setPreferredFramesPerSecond:(NSInteger)aValue {
    _preferredFramesPerSecond = aValue;
    
    self.displayLink.frameInterval = MAX(1, (60 / aValue));
}


#pragma makr - lazy load
- (CADisplayLink*)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawView:)];
    }
    return _displayLink;
}


#pragma mark - displayLink selector
- (void)drawView:(CADisplayLink*)link {
    [(AGLKView*)self.view display];
}

#pragma mark - AGLKViewDelegate
- (void)glkView:(AGLKView *)view drawInRect:(CGRect)rect {
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
                 sizeof(vertices)/sizeof(SceneVertex)); /// 需要渲染的顶点数量
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
