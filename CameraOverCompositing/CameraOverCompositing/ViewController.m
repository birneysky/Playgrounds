//
//  ViewController.m
//  CameraOverCompositing
//
//  Created by Bruce on 2021/7/20.
//

#import "ViewController.h"
#import "VideoCapturer.h"
#import "VideoRender.h"
#import <Accelerate/Accelerate.h>

@interface ViewController () <VideoCapturerOutputDelegate>

@property (nonatomic, strong) VideoCapturer* videoCapture;
@property (weak, nonatomic) IBOutlet id<VideoRender> videoRender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    //    [self.videoCapture startRunning];
    //});
//    NSString* path = [[NSBundle mainBundle] pathForResource:@"poke_sticker" ofType:@"gif"];
//    NSData* data = [NSData dataWithContentsOfFile:path];
//
//    CGImageSourceRef sourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)data, nil);
//
//    NSInteger count = CGImageSourceGetCount(sourceRef);
//    NSMutableArray* images = [[NSMutableArray alloc] initWithCapacity:count];
//    for (int i = 0; i < count; i ++) {
//        CGImageRef cgImg = CGImageSourceCreateImageAtIndex(sourceRef, i, nil);
//        [images addObject:[UIImage imageWithCGImage:cgImg]];
//
//        CGImageRelease(cgImg);
//    }
//    CFRelease(sourceRef);
//
//    self.stickerImage.animationImages = images;
//    self.stickerImage.animationDuration = count * 0.1;
//    [self.stickerImage startAnimating];
    
    
    
    NSLog(@"\nITU_R_601_4:\nYp:%f \n"
          @"Cr_R:%f \n"
          @"Cb_G:%f \n"
          @"Cr_G:%f \n"
          @"Cb_B:%f \n",
          kvImage_YpCbCrToARGBMatrix_ITU_R_601_4->Yp,
          kvImage_YpCbCrToARGBMatrix_ITU_R_601_4->Cr_R,
          kvImage_YpCbCrToARGBMatrix_ITU_R_601_4->Cb_G,
          kvImage_YpCbCrToARGBMatrix_ITU_R_601_4->Cr_G,
          kvImage_YpCbCrToARGBMatrix_ITU_R_601_4->Cb_B);
    
    
    
    NSLog(@"\nITU_R_709_2:\nYp:%f \n"
          @"Cr_R:%f \n"
          @"Cb_G:%f \n"
          @"Cr_G:%f \n"
          @"Cb_B:%f \n",
          kvImage_YpCbCrToARGBMatrix_ITU_R_709_2->Yp,
          kvImage_YpCbCrToARGBMatrix_ITU_R_709_2->Cr_R,
          kvImage_YpCbCrToARGBMatrix_ITU_R_709_2->Cb_G,
          kvImage_YpCbCrToARGBMatrix_ITU_R_709_2->Cr_G,
          kvImage_YpCbCrToARGBMatrix_ITU_R_709_2->Cb_B);
    
    /**
     https://blog.csdn.net/huweijian5/article/details/106209101
     R      Yp    0          Cr_R
     G =    Yp   Cb_G  Cr_G
     B        Yp   Cb_B   0
     */
    
    [self.videoCapture startRunning];
    
    
}

#pragma mark -
- (void)didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    CVPixelBufferRef videoBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    [self.videoRender renderVideoPixelBuffer:videoBuffer];
}

#pragma mark - Getter
- (VideoCapturer*)videoCapture {
    if (!_videoCapture) {
        _videoCapture = [[VideoCapturer alloc] init];
        _videoCapture.delegate = self;
    }
    return _videoCapture;
}
@end
