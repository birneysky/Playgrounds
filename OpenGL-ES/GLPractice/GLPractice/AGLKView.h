//
//  AGLKView.h
//  GLPractice
//
//  Created by birney on 2019/7/24.
//  Copyright © 2019 Grocery. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AGLKViewDrawableDepthFormat) {
    AGLKViewDrawableDepthFormatNone = 0,
    AGLKViewDrawableDepthFormat16,
};

NS_ASSUME_NONNULL_BEGIN

@protocol AGLKViewDelegate;

@interface AGLKView : UIView

@property (nonatomic, weak) id<AGLKViewDelegate> delegate;
@property (nonatomic, strong) EAGLContext* context;
@property (nonatomic, readonly) NSInteger drawableWidth;
@property (nonatomic, readonly) NSInteger drawableHeight;
@property (nonatomic, assign) AGLKViewDrawableDepthFormat drawableDepthFormat;

- (void)display;
@end


@protocol AGLKViewDelegate <NSObject>

@required
- (void)glkView:(AGLKView*)view drawInRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
