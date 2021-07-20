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
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
