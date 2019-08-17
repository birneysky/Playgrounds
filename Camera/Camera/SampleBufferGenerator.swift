//
//  SampleBufferGenerator.swift
//  Camera
//
//  Created by birneysky on 2019/8/17.
//  Copyright © 2019 Grocery. All rights reserved.
//

import Foundation
import AVFoundation
import CoreImage

class SampleBufferGenerator {
    fileprivate var pixelBufferPool: CVPixelBufferPool!
    fileprivate var videoFmtDesc: CMVideoFormatDescription!
    fileprivate var capacity: Int
    fileprivate var width: Int32
    fileprivate var height: Int32
    
    fileprivate lazy var context: CIContext = {
        //let eaglContext = EAGLContext(api: EAGLRenderingAPI.openGLES2)
        let context = CIContext(options: [.workingColorSpace:NSNull()])
        return context
    }()
    
    fileprivate lazy var rgbColorSpace: CGColorSpace  = {
        let space = CGColorSpaceCreateDeviceRGB()
        return space
    }()
    
    init(width: Int32, height: Int32, capacity: Int) {
        self.capacity = capacity
        self.width = width
        self.height = height
        setupBuffersPool()
    }
    
    fileprivate func setupBuffersPool() {
        let pixelBufferAttributes = [
                kCVPixelBufferPixelFormatTypeKey:kCVPixelFormatType_32BGRA,
                kCVPixelBufferWidthKey:self.width,
                kCVPixelBufferHeightKey:self.height,
                kCVPixelBufferOpenGLCompatibilityKey:true,
                kCVPixelBufferIOSurfacePropertiesKey:[:]
            ] as CFDictionary
        let poolAttributes = [
                kCVPixelBufferPoolMinimumBufferCountKey:capacity
            ] as CFDictionary
        
        CVPixelBufferPoolCreate(kCFAllocatorDefault,
                                poolAttributes,
                                pixelBufferAttributes,
                                &self.pixelBufferPool)
        
        var pixelBuffers = [CVPixelBuffer?]()
        while true {
            var cvpixelBuffer: CVPixelBuffer? = nil
            let auxAttribute = [
                    kCVPixelBufferPoolAllocationThresholdKey:capacity
                ] as CFDictionary
            
            let err =
                CVPixelBufferPoolCreatePixelBufferWithAuxAttributes(kCFAllocatorDefault,
                                                                    self.pixelBufferPool,
                                                                    auxAttribute,
                                                                    &cvpixelBuffer)
            
            if err == kCVReturnWouldExceedAllocationThreshold {
                break
            }
            
            pixelBuffers.append(cvpixelBuffer)
        }
        pixelBuffers.removeAll()
    }
    
    func generateSampleBuffer(from inputImage: CIImage, presentationTimeStamp: CMTime) -> CMSampleBuffer? {
        var renderedOutputPixelBuffer: CVPixelBuffer? = nil
        let err = CVPixelBufferPoolCreatePixelBuffer(kCFAllocatorDefault,
                                                     self.pixelBufferPool,
                                                     &renderedOutputPixelBuffer)
        if err != 0 {
            NSLog("Cannot obtain a pixel buffer from the buffer pool")
            return nil
        }
        
        guard let outputPixelBuffer = renderedOutputPixelBuffer else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(outputPixelBuffer, [])
        self.context.render(inputImage,
                            to: outputPixelBuffer,
                            bounds: inputImage.extent,
                            colorSpace: self.rgbColorSpace)
        CVPixelBufferUnlockBaseAddress(outputPixelBuffer, [])
        
        if self.videoFmtDesc == nil {
            CMVideoFormatDescriptionCreateForImageBuffer(allocator: kCFAllocatorDefault,
                                                         imageBuffer: outputPixelBuffer,
                                                         formatDescriptionOut: &videoFmtDesc)
        }
        
        let pstTime = presentationTimeStamp
        var timingInfo = CMSampleTimingInfo(duration: pstTime,
                                            presentationTimeStamp: pstTime,
                                            decodeTimeStamp: CMTime.invalid)
        var finalBuffer: CMSampleBuffer? = nil
        
        //        CMSampleBufferCreateForImageBuffer(allocator: kCFAllocatorDefault, imageBuffer: outputPixelBuffer, dataReady: true, makeDataReadyCallback: nil, refcon: nil, formatDescription: videoFmtDesc, sampleTiming: &timingInfo, sampleBufferOut: &finalBuffer)
        CMSampleBufferCreateReadyWithImageBuffer(allocator: kCFAllocatorDefault,
                                                 imageBuffer: outputPixelBuffer,
                                                 formatDescription: videoFmtDesc,
                                                 sampleTiming: &timingInfo,
                                                 sampleBufferOut: &finalBuffer)
        return finalBuffer
    }

}
