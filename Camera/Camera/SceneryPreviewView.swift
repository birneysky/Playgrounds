//
//  SceneryPreviewView.swift
//  Camera
//
//  Created by birney on 2019/5/20.
//  Copyright © 2019 Grocery. All rights reserved.
//

import UIKit
import AVFoundation

@IBDesignable class SceneryPreviewView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    fileprivate func setup() {
        self.addSubview(self.overlayView)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        self.overlayView.translatesAutoresizingMaskIntoConstraints = false
        self.overlayView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.overlayView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.overlayView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.overlayView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    var displayLayer: AVSampleBufferDisplayLayer  {
        return self.layer as! AVSampleBufferDisplayLayer
    }
    
    lazy var overlayView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let overlayView = UIVisualEffectView(effect: blurEffect)
        return overlayView
    }()
    
    override class var layerClass: AnyClass {
        return AVSampleBufferDisplayLayer.self
    }

}
