//
//  ImageCompositingOverViewController.swift
//  CIFilters
//
//  Created by Bruce on 2021/7/9.
//  Copyright © 2021 COOL. All rights reserved.
//

import UIKit

class ImageCompositingOverViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var time: Timer!
    
    deinit {
       print("ImageCompositingOverViewController ~")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let filter = CIFilter(name: "CITextImageGenerator") else {
            return;
        }
        
        //print(filter.attributes)
        filter.setValue(50, forKey: "inputFontSize")
        guard let klara = UIImage(named: "klara")?.cgImage else {
            return
        }
        let bgImg = CIImage(cgImage: klara)
        
        var count: Int = 0;
        weak var weakSelf = self
        self.time = Timer.scheduledTimer(withTimeInterval: 0.033, repeats: true) { _ in
            filter.setValue(NSString.init(format: "%010d", count), forKey: "inputText")
            guard let outImg = filter.outputImage else {
                return;
            }
            
//            var extent = outImg.extent
//            extent.origin.x = 30
            //print(outImg.extent)
            let transform = CGAffineTransform(translationX: 0, y: 120)
            let textImg = outImg.transformed(by: transform)
            //print(textImg.extent)
            let final = textImg.composited(over: bgImg)
            let img = UIImage(ciImage: final)
            weakSelf?.imageView.image = img
            
            count += 1
        }
        self.time.fire()
        guard let overFilter = CIFilter(name: "CISourceOverCompositing") else {
            return;
        }
        print(overFilter.attributes)
        // Do any additional setup after loading the view.
    }
    
    override func didMove(toParent parent: UIViewController?) {
        if parent == nil {
            self.time.invalidate()
            self.time = nil
        }
    }

}
