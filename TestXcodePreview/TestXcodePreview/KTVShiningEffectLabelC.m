//
//  KTVShiningEffectLabel.m
//  ktv
//
//  Created by Bruce on 2024/8/27.
//

#import "KTVShiningEffectLabelC.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
//#import "KTVImageLoader.h"
#import "KTVNickNameEffectModel.h"
#import "UIColor+Hex.h"

@interface KTVShiningEffectLabelC ()

@property (nonatomic, strong) CATextLayer *textLayer;
@property (nonatomic, strong) CATextLayer *textLayer1;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) NSArray<UIColor *> *colors;
@property (nonatomic, strong) NSArray<NSNumber *> *locations;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) KTVNickNameEffectModel *effect;
@property (nonatomic, strong) UIImageView *frontImageView;


@end

@implementation KTVShiningEffectLabelC

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
    [self.frontImageView removeFromSuperview];
    if (self.effect && self.effect.lightColors.count > 0) {
        self.textLayer = [[CATextLayer alloc] init];
        self.gradientLayer = [[CAGradientLayer alloc] init];
        self.textLayer1 = [[CATextLayer alloc] init];
        self.frontImageView = [[UIImageView alloc] init];
        self.frontImageView.contentMode  = UIViewContentModeScaleAspectFill;
        self.frontImageView.clipsToBounds = YES;
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
        [self addSubview:self.frontImageView];
    
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
   /// [self.frontImageView setImageURLAndLoading:url];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.gradientLayer.frame = self.bounds;
    self.textLayer.frame = self.bounds;
    self.textLayer1.frame = self.bounds;
    CGRect rect = self.bounds;
    rect.size.width = [self calculateTextLayerSize].width;
    if (self.textAlignment == NSTextAlignmentCenter) {
        rect.origin.x = (self.bounds.size.width - rect.size.width) / 2;
    }
    self.frontImageView.frame = rect;
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
    CGSize size = [attributedString boundingRectWithSize:CGSizeMake(self.size.width, CGFLOAT_MAX)
                                                 options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine)
                                                 context:nil].size;
    return CGSizeMake(ceil(size.width), ceil(size.height));
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
    return [super intrinsicContentSize];
}

@end
