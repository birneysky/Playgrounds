//
//  KTVImageView.m
//  TestXcodePreview
//
//  Created by Bruce on 2024/7/12.
//

#import "KTVImageView.h"

@interface DummyLayer : CALayer

@end

@implementation DummyLayer

/// 阻止子类 UIImageView 绘制图片
- (void)setContents:(id)contents {
    [super setContents:nil];
}

@end


@interface KTVImageView ()

@property (nonatomic, strong) UIImage* aimg;

@end

@implementation KTVImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}*/

+ (Class)layerClass {
    return DummyLayer.class;
}


- (void)displayLayer:(CALayer *)layer {
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.delegate = self;
    }
    return self;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    NSLog(@"#####");
}

- (void)setImage:(UIImage *)image {
    _aimg = image;
    [super setImage:nil];
}

- (CGSize)intrinsicContentSize {
    return self.bounds.size;
}

- (UIImage*)image {
    return _aimg;
}


@end

