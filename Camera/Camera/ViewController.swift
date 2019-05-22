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
        guard let imageBuffer = CMSampleBufferGetImageBuffer(buffer) else {
            return;
        }
        let img = CIImage(cvImageBuffer: imageBuffer)
        guard let filer = CIFilter.init(name: "CIFaceBalance") else {
            print("filter  is nil")
            return;
        }
        filer.setValue(img, forKey: "inputImage")
        guard let outputImg = filer.outputImage else {
            print("filter outputimage is nil")
            return
        }
        
        let aDuration = CMSampleBufferGetDuration(buffer)
        let aPts = CMSampleBufferGetPresentationTimeStamp(buffer)
        let aDts = CMSampleBufferGetDecodeTimeStamp(buffer)
        var timingInfo = CMSampleTimingInfo(duration: aDuration, presentationTimeStamp: aPts, decodeTimeStamp: aDts)
        var videoFormat: CMVideoFormatDescription?
        CMVideoFormatDescriptionCreateForImageBuffer(allocator: kCFAllocatorDefault, imageBuffer: imageBuffer, formatDescriptionOut: &videoFormat)
        guard let videoFormatDescription = videoFormat else {
            return
        }
        
        if self.pixelBufferPool == nil {
            let poolAttributes: [CFString:Any]  = [kCVPixelBufferPoolMinimumBufferCountKey:2]
            let inputMediaSubType = CMFormatDescriptionGetMediaSubType(videoFormatDescription)
            
            let inputDimensions = CMVideoFormatDescriptionGetDimensions(videoFormatDescription)
            
            let pixelBufferAttributes: [CFString: Any]  = [
                kCVPixelBufferPixelFormatTypeKey : inputMediaSubType,
                kCVPixelBufferWidthKey : inputDimensions.width,
                kCVPixelBufferHeightKey : inputDimensions.height
            ]
            
            CVPixelBufferPoolCreate(kCFAllocatorDefault, poolAttributes as CFDictionary, pixelBufferAttributes as CFDictionary, &self.pixelBufferPool)
        }
        
        var pbuf: CVPixelBuffer?
        CVPixelBufferPoolCreatePixelBuffer(kCFAllocatorDefault, self.pixelBufferPool, &pbuf)
        guard let outputPixelBuffer = pbuf else {
            print("Allocation failure")
            return
        }
        

        self.context.render(outputImg, to: outputPixelBuffer ,bounds: outputImg.extent, colorSpace: CGColorSpaceCreateDeviceRGB())
//        var outputVideoFormat: CMVideoFormatDescription?
//        CMVideoFormatDescriptionCreateForImageBuffer(allocator: kCFAllocatorDefault, imageBuffer: outputPixelBuffer, formatDescriptionOut: &outputVideoFormat)
//        guard let ovfd = videoFormat else {
//            return
//        }
        var finalSampleBuffer: CMSampleBuffer?
        CMSampleBufferCreateForImageBuffer(allocator: kCFAllocatorDefault, imageBuffer: outputPixelBuffer, dataReady: true, makeDataReadyCallback: nil, refcon: nil, formatDescription: videoFormatDescription, sampleTiming: &timingInfo, sampleBufferOut: &finalSampleBuffer)
        //print(img.autoAdjustmentFilters())
        //DispatchQueue.main.async {
        guard let fsb = finalSampleBuffer else {
            return
        }
        self.displayLayer.enqueue(fsb)
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

