//
//  ViewController.m
//  CameraOverCompositing
//
//  Created by Bruce on 2021/7/20.
//

#import "ViewController.h"
#import "VideoCapturer.h"
#import "VideoRender.h"


@interface ViewController () <VideoCapturerOutputDelegate>

@property (nonatomic, strong) VideoCapturer* videoCapture;
@property (weak, nonatomic) IBOutlet id<VideoRender> videoRender;
@property (weak, nonatomic) IBOutlet UIImageView *stickerImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    //    [self.videoCapture startRunning];
    //});
    NSString* path = [[NSBundle mainBundle] pathForResource:@"poke_sticker" ofType:@"gif"];
    NSData* data = [NSData dataWithContentsOfFile:path];
    
    CGImageSourceRef sourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)data, nil);
    
    NSInteger count = CGImageSourceGetCount(sourceRef);
    NSMutableArray* images = [[NSMutableArray alloc] initWithCapacity:count];
    for (int i = 0; i < count; i ++) {
        CGImageRef cgImg = CGImageSourceCreateImageAtIndex(sourceRef, i, nil);
        [images addObject:[UIImage imageWithCGImage:cgImg]];
        
        CGImageRelease(cgImg);
    }
    CFRelease(sourceRef);
    
    self.stickerImage.animationImages = images;
    self.stickerImage.animationDuration = count * 0.1;
    [self.stickerImage startAnimating];
    
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
