//
//  ViewController.swift
//  Camera
//
//  Created by birneysky on 2019/5/8.
//  Copyright © 2019 Grocery. All rights reserved.
//

import UIKit
import CoreMedia
import AVFoundation
import CoreImage

class ViewController: UIViewController,SceneryCapturerOutputDelegate {

    @IBOutlet weak var previewView: SceneryPreviewView!
    @IBOutlet weak var glview: OpenGLPixelBufferView!
    
    weak var displayLayer: AVSampleBufferDisplayLayer!
    fileprivate var pixelBufferPool: CVPixelBufferPool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayLayer = self.previewView.displayLayer
        print(CIFilter.filterNames(inCategory: kCICategoryVideo))
        // Do any additional setup after loading the view.
        self.capturer.startRunning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }


    func didOutputSampleBuffer(_ buffer: CMSampleBuffer) {
//        guard let imageBuffer = CMSampleBufferGetImageBuffer(buffer) else {
//            return;
//        }
//        let img = CIImage(cvImageBuffer: imageBuffer)
//        guard let filer = CIFilter.init(name: "CIFaceBalance") else {
//            print("filter  is nil")
//            return;
//        }
//        filer.setValue(img, forKey: "inputImage")
//        guard let outputImg = filer.outputImage else {
//            print("filter outputimage is nil")
//            return
//        }
        

 
        
//        if self.pixelBufferPool == nil {
//            let poolAttributes: [CFString:Any]  = [kCVPixelBufferPoolMinimumBufferCountKey:2]
//            let inputMediaSubType = CMFormatDescriptionGetMediaSubType(videoFormatDescription)
//
//            let inputDimensions = CMVideoFormatDescriptionGetDimensions(videoFormatDescription)
//
//            let pixelBufferAttributes: [CFString: Any]  = [
//                kCVPixelBufferPixelFormatTypeKey : inputMediaSubType,
//                kCVPixelBufferWidthKey : inputDimensions.width,
//                kCVPixelBufferHeightKey : inputDimensions.height,
//                kCVPixelBufferIOSurfacePropertiesKey:[:]
//            ]
//
//            CVPixelBufferPoolCreate(kCFAllocatorDefault, poolAttributes as CFDictionary, pixelBufferAttributes as CFDictionary, &self.pixelBufferPool)
//        }
        
//        let pixelBufferAttributes: [CFString: Any]  = [
//            kCVPixelBufferWidthKey : CVPixelBufferGetWidth(imageBuffer),
//            kCVPixelBufferHeightKey : CVPixelBufferGetHeight(imageBuffer)]
//        var pbuf: CVPixelBuffer?
//
//        CVPixelBufferCreate(kCFAllocatorDefault, CVPixelBufferGetWidth(imageBuffer), CVPixelBufferGetHeight(imageBuffer), CVPixelBufferGetPixelFormatType(imageBuffer), pixelBufferAttributes as CFDictionary, &pbuf)
////        CVPixelBufferPoolCreatePixelBuffer(kCFAllocatorDefault, self.pixelBufferPool, &pbuf)
//        guard let outputPixelBuffer = pbuf else {
//            print("Allocation failure")
//            return
//        }
        
        //CVPixelBufferLockBaseAddress(outputPixelBuffer, [0])
        //self.context.render(outputImg, to: outputPixelBuffer ,bounds: outputImg.extent, colorSpace: CGColorSpaceCreateDeviceRGB())
//        self.context.render(outputImg, to: outputPixelBuffer)
        //CVPixelBufferUnlockBaseAddress(outputPixelBuffer, [0])
//        var outputVideoFormat: CMVideoFormatDescription?
//        CMVideoFormatDescriptionCreateForImageBuffer(allocator: kCFAllocatorDefault, imageBuffer: outputPixelBuffer, formatDescriptionOut: &outputVideoFormat)
//        guard let ovfd = videoFormat else {
//            return
//        }
//        var videoFormat: CMVideoFormatDescription? = CMSampleBufferGetFormatDescription(buffer)
//        guard let videoFormatDescription = videoFormat else {
//            return
//        }
        
//        self.glview.display(imageBuffer)
//
//        let aDuration = CMSampleBufferGetDuration(buffer)
//        let aPts = CMTime.invalid //CMSampleBufferGetPresentationTimeStamp(buffer)
//        let aDts = CMTime.invalid //CMSampleBufferGetDecodeTimeStamp(buffer)
//        var timingInfo =  CMSampleTimingInfo(duration: aDuration, presentationTimeStamp: aPts, decodeTimeStamp: aDts)
//
//        var finalSampleBuffer: CMSampleBuffer?
//        CMSampleBufferCreateForImageBuffer(allocator: kCFAllocatorDefault, imageBuffer: outputPixelBuffer, dataReady: false, makeDataReadyCallback: nil, refcon: nil, formatDescription: videoFormatDescription, sampleTiming: &timingInfo, sampleBufferOut: &finalSampleBuffer)
//        CMSampleBufferCreateReadyWithImageBuffer(allocator: kCFAllocatorDefault, imageBuffer: imageBuffer, formatDescription: videoFormatDescription, sampleTiming: &timingInfo, sampleBufferOut: &finalSampleBuffer)
        //print(img.autoAdjustmentFilters())
        //DispatchQueue.main.async {
//        guard let fsb = finalSampleBuffer else {
//            return
//        }
//        if CMSampleBufferInvalidate(fsb) == kCMSampleBufferError_Invalidated {
//
//        }
        if self.displayLayer.isReadyForMoreMediaData {
            self.displayLayer.enqueue(buffer)
        }
//        if self.displayLayer.status ==  .failed {
//            print(self.displayLayer.error)
//        }
        //}
    }
    
    fileprivate lazy var capturer:  SceneryCapturer = {
       let capturer = SceneryCapturer()
        capturer.delegate = self
        return capturer;
    }()
    
    fileprivate lazy var context: CIContext = {
        let eaglContext = EAGLContext(api: EAGLRenderingAPI.openGLES2)
        let context = CIContext(eaglContext: eaglContext!)
        return context
    }()
    
    
}

