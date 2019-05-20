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

class ViewController: UIViewController,SceneryCapturerOutputDelegate {

    @IBOutlet weak var previewView: SceneryPreviewView!
    weak var displayLayer: AVSampleBufferDisplayLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.displayLayer = self.previewView.displayLayer
        self.capturer.startRunning()
    }


    func didOutputSampleBuffer(_ buffer: CMSampleBuffer) {
        self.displayLayer.enqueue(buffer)
    }
    
    fileprivate lazy var capturer:  SceneryCapturer = {
       let capturer = SceneryCapturer()
        capturer.delegate = self
        return capturer;
    }()
}

