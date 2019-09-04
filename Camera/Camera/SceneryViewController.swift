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

class SceneryViewController: UIViewController,SceneryCapturerOutputDelegate {

    @IBOutlet weak var previewView: SceneryPreviewView!
    weak var displayLayer: AVSampleBufferDisplayLayer!
    var generator: SampleBufferGenerator!
    
    fileprivate lazy var capturer:  SceneryCapturer = {
        let capturer = SceneryCapturer()
        capturer.delegate = self
        return capturer;
    }()
    
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
    
    // MARK: - SceneryCapturerOutputDelegate
    func focusDidfinish(at point:CGPoint) {
        self.previewView.setBlurOverView(hidden: true, animated: true)
    }
    
    func didOutputSampleBuffer(_ buffer: CMSampleBuffer) {
          let startTime = clock()
        guard let imageBuffer = CMSampleBufferGetImageBuffer(buffer) else {
            return;
        }
        
        let img = CIImage(cvImageBuffer: imageBuffer)
//        guard let filer = CIFilter.init(name: "CIFaceBalance") else {
//            fatalError("Filter name is not exist")
//        }
        
        guard let filer = CIFilter.init(name: "CIColorInvert") else {
            fatalError("Filter name is not exist")
        }
        
        filer.setValue(img, forKey: "inputImage")
        guard let outputImg = filer.outputImage else {
            fatalError("filter outputimage is nil")
        }
        
        if self.generator == nil {
            guard let description =  CMSampleBufferGetFormatDescription(buffer) else {
                fatalError("buffer fmt description is not found")
            }
            let dimensions =  CMVideoFormatDescriptionGetDimensions(description)
            self.generator = SampleBufferGenerator(width: dimensions.width,
                                                   height: dimensions.height,
                                                   capacity: 6)
        }
        
        let pstTime = CMSampleBufferGetPresentationTimeStamp(buffer);
        let outBuffer = self.generator.generateSampleBuffer(from: outputImg, presentationTimeStamp: pstTime);
        guard let finalBuffer = outBuffer else {
            fatalError("finalBuffer is nil")
        }
        
        let endTime = clock()
        let duration: Double = Double(endTime - startTime) / Double(CLOCKS_PER_SEC)
        print("😇😇😇😇😇 duration:\(duration*1000) ms")

        DispatchQueue.main.async {
            if self.displayLayer.isReadyForMoreMediaData {
                self.displayLayer.enqueue(finalBuffer)
            }
        }
        
    }

    // MARK: - Target Action
    
    @IBAction func switchCameraAction(_ sender: UIButton) {
        let result = self.capturer.swithCamera()
        NSLog("switch camera action result \(result)")
        UIView.animate(withDuration: 0.5) {
            self.previewView.transform =
                CGAffineTransform(a: -1,
                                  b: 0,
                                  c: 0,
                                  d: 1,
                                  tx: 1,
                                  ty: 0)
        }
        
    }
    
}

