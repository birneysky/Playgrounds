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
    fileprivate var videoFmtDesc:CMVideoFormatDescription!
    
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

    func setupBuffersPool(with formatDescription: CMFormatDescription, capacity: Int) {
        let dimensions =  CMVideoFormatDescriptionGetDimensions(formatDescription)
        let pixelBufferAttributes = [
            kCVPixelBufferPixelFormatTypeKey:kCVPixelFormatType_32BGRA,
            kCVPixelBufferWidthKey:dimensions.width,
            kCVPixelBufferHeightKey:dimensions.height,
            kCVPixelBufferOpenGLCompatibilityKey:true,
            kCVPixelBufferIOSurfacePropertiesKey:[:]
        ] as CFDictionary
        let poolAttributes = [
            kCVPixelBufferPoolMinimumBufferCountKey:capacity
        ] as CFDictionary
        CVPixelBufferPoolCreate(kCFAllocatorDefault, poolAttributes, pixelBufferAttributes, &self.pixelBufferPool)
        
        var pixelBuffers = [CVPixelBuffer?]()
        while true {
            var cvpixelBuffer: CVPixelBuffer? = nil
            let auxAttribute = [
                kCVPixelBufferPoolAllocationThresholdKey:capacity
            ] as CFDictionary
            let err = CVPixelBufferPoolCreatePixelBufferWithAuxAttributes(kCFAllocatorDefault, self.pixelBufferPool, auxAttribute, &cvpixelBuffer)
            if err == kCVReturnWouldExceedAllocationThreshold {
                break
            }
            pixelBuffers.append(cvpixelBuffer)
        }
        pixelBuffers.removeAll()
    }
    
    func didOutputSampleBuffer(_ buffer: CMSampleBuffer) {
          let startTime = clock()
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
        
        if self.pixelBufferPool == nil {
            let description =  CMSampleBufferGetFormatDescription(buffer)
            setupBuffersPool(with: description!, capacity: 6)
        }
        
        var renderedOutputPixelBuffer: CVPixelBuffer? = nil
        let err = CVPixelBufferPoolCreatePixelBuffer(kCFAllocatorDefault, self.pixelBufferPool, &renderedOutputPixelBuffer)
        if err != 0 {
            print("Cannot obtain a pixel buffer from the buffer pool")
            return
        }
        
        guard let outputPixelBuffer = renderedOutputPixelBuffer else {
            return
        }
        
        CVPixelBufferLockBaseAddress(outputPixelBuffer, [])
        self.context.render(outputImg, to: outputPixelBuffer, bounds: outputImg.extent, colorSpace: self.rgbColorSpace)
        CVPixelBufferUnlockBaseAddress(outputPixelBuffer, [])
        
        //self.glview.display(outputPixelBuffer)
        
        if self.videoFmtDesc == nil {
            CMVideoFormatDescriptionCreateForImageBuffer(allocator: kCFAllocatorDefault, imageBuffer: outputPixelBuffer, formatDescriptionOut: &videoFmtDesc)
        }

        let pstTime = CMSampleBufferGetPresentationTimeStamp(buffer);
        var timingInfo = CMSampleTimingInfo(duration: pstTime, presentationTimeStamp: pstTime, decodeTimeStamp: CMTime.invalid)
        var finalBuffer: CMSampleBuffer? = nil
//        CMSampleBufferCreateForImageBuffer(allocator: kCFAllocatorDefault, imageBuffer: outputPixelBuffer, dataReady: true, makeDataReadyCallback: nil, refcon: nil, formatDescription: videoFmtDesc, sampleTiming: &timingInfo, sampleBufferOut: &finalBuffer)
        CMSampleBufferCreateReadyWithImageBuffer(allocator: kCFAllocatorDefault, imageBuffer: outputPixelBuffer, formatDescription: videoFmtDesc, sampleTiming: &timingInfo, sampleBufferOut: &finalBuffer)
        
        if self.displayLayer.isReadyForMoreMediaData {
            self.displayLayer.enqueue(finalBuffer!)
        }
        
        let endTime = clock()
        let duration: Double = Double(endTime - startTime) / Double(CLOCKS_PER_SEC)
        print("😇😇😇😇😇 duration:\(duration*1000) ms")
    }
    
    fileprivate lazy var capturer:  SceneryCapturer = {
       let capturer = SceneryCapturer()
        capturer.delegate = self
        return capturer;
    }()
    
    fileprivate lazy var context: CIContext = {
        //let eaglContext = EAGLContext(api: EAGLRenderingAPI.openGLES2)
        let context = CIContext(options: [.workingColorSpace:NSNull()])
        return context
    }()
    
    fileprivate lazy var rgbColorSpace: CGColorSpace  = {
        let space = CGColorSpaceCreateDeviceRGB()
        return space
    }()
    
    
}

