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
    weak var displayLayer: AVSampleBufferDisplayLayer? {
        return self.previewView.displayLayer
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(CIFilter.filterNames(inCategory: kCICategoryVideo))
        // Do any additional setup after loading the view.
        
        self.capturer.startRunning()
    }


    func didOutputSampleBuffer(_ buffer: CMSampleBuffer) {
//        guard let imageBuffer = CMSampleBufferGetImageBuffer(buffer) else {
//            return;
//        }
//        let img = CIImage(cvImageBuffer: imageBuffer)
//        guard let filer = CIFilter.init(name: "CIFaceBalance") else {
//            return;
//        }
//        filer.setValue(img, forKey: "inputImage")
//        guard let outputImg = filer.outputImage else {
//            return
//        }
        //print(img.autoAdjustmentFilters())
        self.displayLayer?.enqueue(buffer)
    }
    
    fileprivate lazy var capturer:  SceneryCapturer = {
       let capturer = SceneryCapturer()
        capturer.delegate = self
        return capturer;
    }()
}

