//
//  AGLKViewController.m
//  GLPractice
//
//  Created by birney on 2019/7/24.
//  Copyright © 2019 Grocery. All rights reserved.
//

#import "AGLKViewController.h"
#import "AGLKView.h"

const NSInteger kAGLKDefaultFramesPerSecond = 30;

@interface AGLKViewController () <AGLKViewDelegate>

@property (nonatomic, strong) CADisplayLink* displayLink;
@property (nonatomic, assign) NSInteger preferredFramesPerSecond;
@property (nonatomic, assign, getter=isPaused) BOOL paused;
@end

@implementation AGLKViewController

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
