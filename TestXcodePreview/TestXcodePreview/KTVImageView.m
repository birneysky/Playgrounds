//
//  KTVImageView.m
//  TestXcodePreview
//
//  Created by Bruce on 2024/7/12.
//

#import "KTVImageView.h"

@interface DummyLayer : CALayer
@property (nonatomic, strong) id acontents;
@end

@implementation DummyLayer

/// 阻止子类 UIImageView 绘制图片
- (void)setContents:(id)contents {
    [super setContents:nil];
    self.acontents = contents;
}

@end

///  如果子类化一个 UIImageView， 让其真正的图片渲染由其子视图负责。
///  这样做的话，当这个这个图片从 xib 中加载会遇到到问题
///  就是 xib 中设置的图片并不能正确的加载显示。
///  无论在 awakeFromNib 获取 self.image 还是在
///  (instancetype)initWithCoder:(NSCoder *)coder 方法中通过 [coder decodeObjectForKey::@"image"】 获取图片名都不能正确获取图片对象，
///  这里为什么key 是 image，是因为在 xib 的xml文件中这个图片名使用的 image，例如这样 image="ktv_past_self_icon"。
///  如何才能获取到image 对象呢，这里的方法是自定义 Layer。
///  由于图片真正渲染是通过 CALayer 来渲染的，这个子类化 Layer 有两个好处
///  1 防止图片在父试图上进行无效渲染
///  2 可以存储从 xib 中获取的 image 对象
@interface KTVImageView ()

@property (nonatomic, strong) UIImage* aimg;
@property (nonatomic, strong) UIImageView* subImageView;
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


- (void)setupSubImageView {
    self.subImageView = [[UIImageView alloc] init];
    [self addSubview:self.subImageView];
    [self setImage:self.image];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.subImageView.frame = self.bounds;
}

- (void)displayLayer:(CALayer *)layer {
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubImageView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setupSubImageView];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super initWithImage:image]) {
        [self setupSubImageView];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    if (self = [super initWithImage:image highlightedImage:highlightedImage]) {
        [self setupSubImageView];
    }
    return  self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    if (self.image) {
        self.subImageView.image = self.image;
    } else {
        self.subImageView.image = ((DummyLayer*)self.layer).acontents;
    }
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
}

- (void)setImage:(UIImage *)image {
    [super setImage:image];
//    _aimg = image;
//    self.subImageView.image = image;

}

//- (CGSize)intrinsicContentSize {
//    return self.subImageView.intrinsicContentSize;
//}

//- (UIImage*)image {
//    return _aimg;
//}


@end

