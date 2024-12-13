//
//  KTVShiningEffectLabel.m
//  ktv
//
//  Created by Bruce on 2024/8/27.
//

#import "KTVShiningEffectLabel1.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
//#import "KTVImageLoader.h"
#import "KTVNickNameEffectModel.h"
#import "UIColor+Hex.h"
#import <CoreText/CoreText.h>

@interface KTVShiningEffectLabel1 ()

@property (nonatomic, strong) CATextLayer *textLayer;
@property (nonatomic, strong) CATextLayer *textLayer1;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) NSArray<UIColor *> *colors;
@property (nonatomic, strong) NSArray<NSNumber *> *locations;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) KTVNickNameEffectModel *effect;
//@property (nonatomic, strong) KTVImageView *frontImageView;


@end

@implementation KTVShiningEffectLabel1

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
}

- (CGPoint)calculateStartPoint:(CGFloat)angleInDegrees {
    CGFloat degress = angleInDegrees;
    CGPoint startPoint = CGPointMake(0, 1);
    if (angleInDegrees > 45 && angleInDegrees <= 90) {
        degress = 90 - angleInDegrees;
    }
    if (angleInDegrees > 90) {
        return startPoint;
    }
    CGFloat angleInRadians = degress * M_PI / 180;
    CGFloat tanValue = tan(angleInRadians);
    if (angleInDegrees <= 45) {
        startPoint =  CGPointMake(0, 1 - tanValue);
    } else {
        startPoint  = CGPointMake(1-tanValue, 0);
    }
    return startPoint;
}

- (void)setup {
    [self.gradientLayer removeFromSuperlayer];
    [self.textLayer1 removeFromSuperlayer];
    //[self.frontImageView removeFromSuperview];
    if (self.effect && self.effect.lightColors.count > 0) {
        self.textLayer = [[CATextLayer alloc] init];
        self.gradientLayer = [[CAGradientLayer alloc] init];
        self.textLayer1 = [[CATextLayer alloc] init];
//        self.frontImageView = [[KTVImageView alloc] init];
//        self.frontImageView.contentMode  = UIViewContentModeScaleAspectFill;
//        self.frontImageView.clipsToBounds = YES;
        NSMutableArray *colors = [NSMutableArray array];
        for (NSString *colorString in self.effect.lightColors) {
            [colors addObject:rgba(colorString)];
        }
        
        self.locations = self.effect.positions;
        self.colors = colors;
        self.gradientLayer.colors = [self mapColorsToCGColor:self.colors];
        self.gradientLayer.locations = self.locations;
        CGPoint startPoint =  [self calculateStartPoint:self.effect.degree];
        self.gradientLayer.startPoint = startPoint;
        self.gradientLayer.endPoint = CGPointMake(1, 1);
        [self layoutIfNeeded];
        [self.layer insertSublayer:self.gradientLayer atIndex:0];
        
        
        // 设置渐变层的遮罩
        self.gradientLayer.mask = self.textLayer;
        
        // 开始动画
        //[self.layer addSublayer:self.textLayer1];
        [self.layer insertSublayer:self.textLayer1 above:self.gradientLayer];
        //[self addSubview:self.frontImageView];
    
        [self setImageURL:[NSURL URLWithString: self.effect.webp]];
        [self startAnimation: self.effect.duration];
    } else {
        self.textLayer1 = [[CATextLayer alloc] init];
        [self.layer insertSublayer:self.textLayer1 atIndex:0];
        self.textLayer1.foregroundColor = self.textColor.CGColor;
        [self updateTextLayer];
        [self setNeedsLayout];
    }
}

- (void)setEffect:(KTVNickNameEffectModel *)effect {
    _effect = effect;
    [self setup];
    [self setNeedsDisplay];
}

- (void)setImageURL:(NSURL *)url {
    _imageURL = url;
    __weak typeof(self) weakSelf = self;
    //[self.frontImageView setImageURLAndLoading:url];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //self.gradientLayer.frame = self.bounds;
    
    //self.textLayer1.frame = self.bounds;

    CGSize contentSize = [self calculateTextLayerSize];
    CGRect rect = self.bounds;
    rect.size.width = contentSize.width;
    if (self.textAlignment == NSTextAlignmentCenter) {
        rect.origin.x = (self.bounds.size.width - rect.size.width) / 2;
    }
    //self.frontImageView.frame = rect;
    rect.origin.y = (self.bounds.size.height - contentSize.height)/2;
    rect.size.height = contentSize.height;
    
    self.gradientLayer.frame = rect;
    self.textLayer.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);
    self.textLayer1.frame = rect;
    [self updateTextLayer];
}

- (void)updateTextLayer {
    self.textLayer.string = self.text;
    self.textLayer.font = (__bridge CFTypeRef)self.font;
    self.textLayer.fontSize = self.font.pointSize;
    self.textLayer.alignmentMode = [self alignmentModeFromTextAlignment:self.textAlignment];
    self.textLayer.contentsScale = [UIScreen mainScreen].scale;
    self.textLayer.truncationMode = kCATruncationEnd;
    
    if (self.effect && self.effect.lightColors.count > 0) {
        self.textLayer1.string = [self createAttributedStringFrom:self.text];
    } else {
        self.textLayer1.string = self.text;
    }
    self.textLayer1.font = (__bridge CFTypeRef)self.font;
    self.textLayer1.fontSize = self.font.pointSize;
    self.textLayer1.alignmentMode = [self alignmentModeFromTextAlignment:self.textAlignment];
    self.textLayer1.contentsScale = [UIScreen mainScreen].scale;
    self.textLayer1.truncationMode = kCATruncationEnd;
    self.textLayer1.foregroundColor = self.textColor.CGColor;
}

- (NSString *)alignmentModeFromTextAlignment:(NSTextAlignment)textAlignment {
    switch (textAlignment) {
        case NSTextAlignmentLeft:
            return kCAAlignmentLeft;
        case NSTextAlignmentRight:
            return kCAAlignmentRight;
        case NSTextAlignmentCenter:
            return kCAAlignmentCenter;
        case NSTextAlignmentJustified:
            return kCAAlignmentJustified;
        case NSTextAlignmentNatural:
            return kCAAlignmentNatural;
        default:
            return kCAAlignmentNatural;
    }
}

- (void)setText:(NSString *)text {
    super.text = text;
    [self updateTextLayer];
    [self invalidateIntrinsicContentSize];
}

- (void)startAnimation:(CFTimeInterval)duration {
    if ([self.gradientLayer animationForKey:@"shimmerEffect"]) {
        [self.gradientLayer removeAnimationForKey:@"shimmerEffect"];
    }
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
    animation.fromValue = [self mapLocationsWithOffset:-1];
    animation.toValue = [self mapLocationsWithOffset:1];
    animation.duration = duration;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    [self.gradientLayer addAnimation:animation forKey:@"shimmerEffect"];
}

- (NSArray *)mapColorsToCGColor:(NSArray<UIColor *> *)colors {
    NSMutableArray *cgColors = [NSMutableArray array];
    for (UIColor *color in colors) {
        [cgColors addObject:(__bridge id)color.CGColor];
    }
    return cgColors;
}

- (NSArray *)mapLocationsWithOffset:(CGFloat)offset {
    NSMutableArray *newLocations = [NSMutableArray array];
    for (NSNumber *location in self.locations) {
        [newLocations addObject:@(location.floatValue + offset)];
    }
    return newLocations;
}

- (CGSize)calculateTextLayerSize {
    if (!self.text || !self.font) {
        return CGSizeZero;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    
    NSDictionary *attributes = @{
        NSFontAttributeName: self.font,
        NSParagraphStyleAttributeName: paragraphStyle
    };
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.text attributes:attributes];
//    CGSize size = [attributedString boundingRectWithSize:CGSizeMake(self.size.width, CGFLOAT_MAX)
//                                                 options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine)
//                                                 context:nil].size;
//    return CGSizeMake(ceil(size.width), ceil(size.height));

    return [self sizeForAttributedString:attributedString maxHeight:CGFLOAT_MAX];
}


- (CGSize)sizeForAttributedString:(NSAttributedString *)attributedString maxHeight:(CGFloat)maxHeight {
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:attributedString];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    
    // 创建 NSTextContainer
    CGSize maxSize = CGSizeMake(self.bounds.size.width, maxHeight);
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:maxSize];
    textContainer.lineFragmentPadding = 0; // 去除内边距
    textContainer.lineBreakMode = self.lineBreakMode; // 换行模式
    [layoutManager addTextContainer:textContainer];
    
    // 计算文本显示所需的高度
    [layoutManager glyphRangeForTextContainer:textContainer];
    CGRect textBounds = [layoutManager usedRectForTextContainer:textContainer];
    
    // 返回取整后的尺寸
    return CGSizeMake(ceil(CGRectGetWidth(textBounds)), ceil(CGRectGetHeight(textBounds)));
}

- (NSAttributedString *)createAttributedStringFrom:(NSString *)text {
    if (text.length <= 0) {
        return nil;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];

    NSString *emojiPattern = @"[\\p{Emoji}\\p{Emoji_Presentation}\\p{Emoji_Modifier}\\p{Emoji_Modifier_Base}\\p{Emoji_Component}&&[^0-9]]";

    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:emojiPattern options:0 error:&error];
    if (error) {
        NSLog(@"Failed to create regex: %@", error);
    }

    NSRange textRange = NSMakeRange(0, text.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:textRange];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:textRange];

    NSArray *matches = [regex matchesInString:text options:0 range:textRange];
    for (NSTextCheckingResult *match in matches) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:self.textColor range:match.range];
    }

    return attributedString;
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.height = size.height + 8;
    return size;
}

@end
