//
//  RCSightCapturer.m
//  RongExtensionKit
//
//  Created by Bruce on 2021/7/20
//

#import "VideoCapturer.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

@interface VideoCapturer () <AVCaptureVideoDataOutputSampleBufferDelegate,
                               AVCaptureAudioDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureDeviceInput *activeVideoInput;
@property (nonatomic, strong) AVCaptureDevice *videoDevice;
@property (nonatomic, strong) dispatch_queue_t sessionQueue;
@property (nonatomic, strong) AVCaptureConnection *videoConnection;
@property (nonatomic, assign) AVCaptureVideoOrientation videoBufferOrientation;
@property (nonatomic, copy) NSDictionary *videoCompressionSettings;
@property (nonatomic, assign) BOOL addAdjustingFocusKVOFlag;
@property (nonatomic, strong) NSTimer *adjustingFocusTimeoutTimer;

@end

@implementation VideoCapturer

- (instancetype)init {
    if (self = [super init]) {
        [self setupCaptureSession];
    }
    return self;
}

- (instancetype)initWithVideoPreviewPlayer:(AVCaptureVideoPreviewLayer *)layer {
    if (self = [super init]) {
        layer.videoGravity = AVLayerVideoGravityResizeAspect;
        layer.session = self.captureSession;
        [self setupCaptureSession];
    }
    return self;
}

- (void)dealloc {
    if (self.addAdjustingFocusKVOFlag) {
        [[self activeCamera] removeObserver:self forKeyPath:@"adjustingFocus"];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Properties
- (AVCaptureSession *)captureSession {
    if (!_captureSession) {
        _captureSession = [[AVCaptureSession alloc] init];
    }
    return _captureSession;
}


- (AVCaptureDevice *)videoDevice {
    if (!_videoDevice) {
        _videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _videoDevice;
}

- (dispatch_queue_t)sessionQueue {
    if (!_sessionQueue) {
        _sessionQueue = dispatch_queue_create("video.capturer.session", DISPATCH_QUEUE_SERIAL);
    }
    return _sessionQueue;
}


#pragma mark - Helper
- (void)setupCaptureSession {

    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(sessionWasInterrupted:)
                          name:AVCaptureSessionWasInterruptedNotification
                        object:nil];

    /*video*/
    AVCaptureDeviceInput *videoDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:self.videoDevice error:nil];
    if ([self.captureSession canAddInput:videoDeviceInput]) {
        [self.captureSession addInput:videoDeviceInput];
        self.activeVideoInput = videoDeviceInput;
    }

    AVCaptureVideoDataOutput *videoDeviceOutput = [[AVCaptureVideoDataOutput alloc] init];
    [videoDeviceOutput setSampleBufferDelegate:self queue:self.sessionQueue];
    videoDeviceOutput.alwaysDiscardsLateVideoFrames = NO;

    if ([self.captureSession canAddOutput:videoDeviceOutput]) {
        [self.captureSession addOutput:videoDeviceOutput];
    }

    self.videoConnection = [videoDeviceOutput connectionWithMediaType:AVMediaTypeVideo];


    self.captureSession.sessionPreset = AVCaptureSessionPresetHigh;

    CMTime frameDuration = CMTimeMake(1, 30);

    NSError *error = nil;
    if ([self.videoDevice lockForConfiguration:&error]) {
        self.videoDevice.activeVideoMaxFrameDuration = frameDuration;
        self.videoDevice.activeVideoMinFrameDuration = frameDuration;
        [self.videoDevice unlockForConfiguration];
    }


    self.videoCompressionSettings =
        [[videoDeviceOutput recommendedVideoSettingsForAssetWriterWithOutputFileType:AVFileTypeMPEG4] copy];

    self.videoConnection.videoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoBufferOrientation = self.videoConnection.videoOrientation;
    

    [self focusAtPoint:CGPointMake(0.5, 0.5)];
}

- (void)teardownCaptureSession {
    if (self.captureSession) {
        self.captureSession = nil;
    }
}

- (BOOL)canSwitchCameras {
    return self.cameraCount > 1;
}

- (NSUInteger)cameraCount {
    return [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            return device;
        }
    }
    return nil;
}

- (AVCaptureDevice *)activeCamera {
    return self.activeVideoInput.device;
}

- (AVCaptureDevice *)inactiveCamera {
    AVCaptureDevice *device = nil;
    if (self.cameraCount > 1) {
        if (AVCaptureDevicePositionBack == [self activeCamera].position) {
            device = [self cameraWithPosition:AVCaptureDevicePositionFront];
        } else {
            device = [self cameraWithPosition:AVCaptureDevicePositionBack];
        }
    }
    return device;
}

- (void)adjustingFocusTimeout {
    [self removeAdjustingFocusObserverIfNeeded];
}

- (UIImage *)fixOrientationOfImage:(UIImage *)image {
    if (image.imageOrientation == UIImageOrientationUp)
        return image;

    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [image drawInRect:(CGRect){0, 0, image.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

#pragma mark - Api

- (NSDictionary *)recommendedVideoCompressionSettings {
    NSDictionary *systemSettings = [self.videoCompressionSettings copy];
    NSDictionary *settings = @{
        AVVideoCodecKey : @"avc1",
        AVVideoHeightKey : @([systemSettings[@"AVVideoHeightKey"] integerValue] / 2),
        AVVideoWidthKey : @([systemSettings[@"AVVideoWidthKey"] integerValue] / 2),
        AVVideoCompressionPropertiesKey : @{
            AVVideoMaxKeyFrameIntervalDurationKey : @(5),
            AVVideoAverageBitRateKey : @(1024 * 1024),
            AVVideoProfileLevelKey : AVVideoProfileLevelH264HighAutoLevel,
            AVVideoExpectedSourceFrameRateKey : @(20)
        }
    };
    /*
     NSMutableDictionary *settings = [[NSMutableDictionary alloc]
     initWithDictionary:self.videoCompressionSettings];
     settings[@"AVVideoCodecKey"] = @"avc1";
     settings[@"AVVideoHeightKey"] = @([settings[@"AVVideoHeightKey"] integerValue] / 2);
     settings[@"AVVideoWidthKey"] = @([settings[@"AVVideoWidthKey"] integerValue] / 2);
     settings[@"AVVideoCompressionPropertiesKey"][@"MaxKeyFrameIntervalDuration"] = @(5);
     settings[@"AVVideoCompressionPropertiesKey"][@"AverageBitRate"] = @(1024 * 1024);
     settings[@"AVVideoCompressionPropertiesKey"][@"ProfileLevel"] = @"H264_High_AutoLevel";
     [settings[@"AVVideoCompressionPropertiesKey"] removeObjectForKey:@"SoftMaxQuantizationParameter"];
     [settings[@"AVVideoCompressionPropertiesKey"] removeObjectForKey:@"SoftMinQuantizationParameter"];
     [settings[@"AVVideoCompressionPropertiesKey"] removeObjectForKey:@"RelaxAverageBitRateTarget"];
     [settings[@"AVVideoCompressionPropertiesKey"] removeObjectForKey:@"AllowOpenGOP"];
     [settings[@"AVVideoCompressionPropertiesKey"] removeObjectForKey:@"MaxQuantizationParameter"];
     [settings[@"AVVideoCompressionPropertiesKey"] removeObjectForKey:@"MinimizeMemoryUsage"];
     */
    return [settings copy]; //[self.videoCompressionSettings copy];
}

- (void)startRunning {
    if (![self.captureSession isRunning]) {
        __weak typeof(self) weakSelf = self;
        dispatch_async(self.sessionQueue, ^{
            [weakSelf.captureSession startRunning];
        });
    }
}

- (void)stopRunning {
    if ([self.captureSession isRunning]) {
        __weak typeof(self) weakSelf = self;
        dispatch_async(self.sessionQueue, ^{
            [weakSelf.captureSession stopRunning];
            [weakSelf teardownCaptureSession];
        });
    }
}

- (void)removeAdjustingFocusObserverIfNeeded {
    if (self.addAdjustingFocusKVOFlag && [self cameraSupportsTapToFocus]) {
        [[self activeCamera] removeObserver:self forKeyPath:@"adjustingFocus"];
        self.addAdjustingFocusKVOFlag = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(focusDidfinish:)]) {
                [self.delegate focusDidfinish:[self activeCamera].focusPointOfInterest];
            }
        });
    }
}

- (BOOL)resetSessionInput {
    if (![self canSwitchCameras]) {
        return NO;
    }
    if (self.adjustingFocusTimeoutTimer) {
        [self.adjustingFocusTimeoutTimer invalidate];
    }
    [self removeAdjustingFocusObserverIfNeeded];
    NSError *error;
    AVCaptureDevice *videoDevice = [self activeCamera];

    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];

    if (videoInput) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self.captureSession beginConfiguration];
            [self.captureSession removeInput:self.activeVideoInput];
            if ([self.captureSession canAddInput:videoInput]) {
                [self.captureSession addInput:videoInput];
                self.activeVideoInput = videoInput;
            } else {
                [self.captureSession addInput:self.activeVideoInput];
            }
            [self.captureSession commitConfiguration];
        });
    } else {
        ////error
        return NO;
    }
    return YES;
}

- (BOOL)switchCamera {
    if (![self canSwitchCameras]) {
        return NO;
    }
    if (self.adjustingFocusTimeoutTimer) {
        [self.adjustingFocusTimeoutTimer invalidate];
    }
    [self removeAdjustingFocusObserverIfNeeded];
    NSError *error;
    AVCaptureDevice *videoDevice = [self inactiveCamera];

    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];

    if (videoInput) {
        [self.captureSession beginConfiguration];
        [self.captureSession removeInput:self.activeVideoInput];
        if ([self.captureSession canAddInput:videoInput]) {
            [self.captureSession addInput:videoInput];
            self.activeVideoInput = videoInput;
        } else {
            [self.captureSession addInput:self.activeVideoInput];
        }
        [self.captureSession commitConfiguration];
    } else {
        ////error
        return NO;
    }
    return YES;
}

- (BOOL)cameraSupportsTapToFocus {
    return [[self activeCamera] isFocusPointOfInterestSupported] &&
           [[self activeCamera] isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus];
}

- (void)focusAtPoint:(CGPoint)point {
    if (self.addAdjustingFocusKVOFlag) {
        return;
    }
    AVCaptureDevice *device = [self activeCamera];
    if (device.isFocusPointOfInterestSupported && [device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {

        [device addObserver:self
                 forKeyPath:@"adjustingFocus"
                    options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                    context:nil];
        self.addAdjustingFocusKVOFlag = YES;
        self.adjustingFocusTimeoutTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                                           target:self
                                                                         selector:@selector(adjustingFocusTimeout)
                                                                         userInfo:nil
                                                                          repeats:NO];
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            device.focusPointOfInterest = point;
            device.focusMode = AVCaptureFocusModeContinuousAutoFocus;
            [device unlockForConfiguration];
        } else {
            NSLog(@"error %@", error);
        }
    }
}


#pragma mark - AVCaptureAudioDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection {
    [self.delegate didOutputSampleBuffer:sampleBuffer];
}

#pragma mark - RCSightRecorderDelegate
- (void)didWriteMovieAtURL:(NSURL *)outputURL {
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeVideoAtPathToSavedPhotosAlbum:outputURL
                                completionBlock:^(NSURL *assetURL, NSError *error){

                                }];
}

#pragma mark - Notification Selector
- (void)sessionWasInterrupted:(NSNotification *)notification {
    NSLog(@"Capture session was interrupted with reason: %@", notification);
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"adjustingFocus"] && object == [self activeCamera]) {
        long oldValue = [[change objectForKey:NSKeyValueChangeOldKey] longValue];
        long newValue = [[change objectForKey:NSKeyValueChangeNewKey] longValue];
        if (oldValue == newValue) {
            return;
        }
        AVCaptureDevice *device = object;
        BOOL adjustingFocus = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        if (!adjustingFocus) {
            if (self.addAdjustingFocusKVOFlag) {
                [device removeObserver:self forKeyPath:@"adjustingFocus"];
                self.addAdjustingFocusKVOFlag = NO;
                [self.adjustingFocusTimeoutTimer invalidate];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.delegate respondsToSelector:@selector(focusDidfinish:)]) {
                    [self.delegate focusDidfinish:device.focusPointOfInterest];
                }
            });
            
        }
    }
}
@end
