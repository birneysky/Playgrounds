//
//  EAGLVideoView.h
//  CameraOverCompositing
//
//  Created by Bruce on 2021/7/20.
//

#import <UIKit/UIKit.h>
#import "VideoRender.h"
NS_ASSUME_NONNULL_BEGIN

@interface EAGLVideoView : UIView <VideoRender>

- (void)renderVideoPixelBuffer:(CVPixelBufferRef)frame;

@end

NS_ASSUME_NONNULL_END
