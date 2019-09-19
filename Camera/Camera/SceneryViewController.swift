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

class SceneryViewController: UIViewController {

    @IBOutlet var backPreview: SceneryPreviewView!
    @IBOutlet var frontPreView: SceneryPreviewView!
    @IBOutlet weak var sceneryView: UIView!
    @IBOutlet weak var backgroundView: UIImageView!
    weak var displayLayer: AVSampleBufferDisplayLayer?
    var generator: SampleBufferGenerator!
    
    // MARK: - Lazy load
    fileprivate lazy var capturer:  SceneryCapturer = {
        let capturer = SceneryCapturer()
        capturer.delegate = self
        return capturer;
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayLayer = self.backPreview.displayLayer
        print(CIFilter.filterNames(inCategory: kCICategoryVideo))

        self.capturer.startRunning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
   
    // MARK: - Target Action
    @IBAction func switchCameraAction(_ sender: UIButton) {
        var fromView: SceneryPreviewView! = nil
        var toView: SceneryPreviewView! = nil
        var aOptions: UIView.AnimationOptions = .transitionFlipFromLeft

        switch self.capturer.cameraPostion {
        case .back:
            fromView = self.backPreview
            toView = self.frontPreView
        case .front:
            fromView = self.frontPreView
            toView = self.backPreview
            aOptions = .transitionFlipFromRight
        default:
            fatalError()
        }
      
        fromView.setBlurOverView(hidden: false, animated: false)
        let snap = fromView.snapshotView(afterScreenUpdates: false)
        let shotImg =  snap?.snapshot()
        if let img = shotImg {
            self.backgroundView.insertSubview(snap!, at: 0)
            //self.sceneryView.backgroundColor = UIColor(patternImage: img)
            //self.backgroundView.image = img
            //self.backgroundView.backgroundColor = UIColor(patternImage: img)
        }
        
        //toView.setBlurOverView(hidden: false, animated: false)
        self.displayLayer = toView.displayLayer
        
        UIView.transition(from: fromView,
                          to: toView,
                          duration: 5,
                          options: aOptions)
        { _ in
            let result = self.capturer.swithCamera()
            NSLog("switch camera action result \(result)")
            snap?.removeFromSuperview()
            self.capturer.focus(at: .init(x: 0.5, y: 0.5))
            guard let superView = toView.superview else {
                fatalError()
            }
            
            superView.removeConstraints(toView.constraints)
            toView.translatesAutoresizingMaskIntoConstraints = false
            toView.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
            toView.rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
            toView.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
            toView.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        }
    }
    
}

// MARK: - SceneryCapturerOutputDelegate
extension SceneryViewController: SceneryCapturerOutputDelegate {
     
        func focusDidfinish(at point:CGPoint) {
            self.backPreview.setBlurOverView(hidden: true, animated: true)
            self.frontPreView.setBlurOverView(hidden: true, animated: true)
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
                if self.displayLayer?.isReadyForMoreMediaData ?? false {
                    self.displayLayer?.enqueue(finalBuffer)
                }
            }
            
        }
}

extension UIView {
    func snapshot() -> UIImage? {
        UIGraphicsBeginImageContext(self.bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            fatalError("UIGraphicsGetCurrentContext return nil")
        }
        self.layer .render(in: context)
        let shotImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return shotImg
    }
}

