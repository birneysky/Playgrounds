//
//  ViewController.swift
//  CustomizedFilter
//
//  Created by birneysky on 2019/5/23.
//  Copyright © 2019 Grocery. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    lazy var mirrorFilter: MirrorXFilter = {
       let mirrorFilter = MirrorXFilter()
        return mirrorFilter
    }()
    
    lazy var context: CIContext = {
        //let egaContext = EAGLContext(api: .openGLES2)
        let context = CIContext(options: nil)
        return context
    }()
    
    lazy var ciImg: CIImage? = {
        let img = UIImage(named: "img_008")
        guard let cgImg = img?.cgImage else {
            return nil
        }
        let ciimge = CIImage(cgImage: cgImg)
        return ciimge
    }()

    @IBAction func mirrorAction(_ sender: Any) {
        
        self.mirrorFilter.inputImage = self.ciImg
        guard let outputImg = self.mirrorFilter.outputImage else {
            return
        }
        let startTime = clock()
        guard let cgImg = self.context.createCGImage(outputImg, from: outputImg.extent) else {
            return
        }
        let endTime = clock()
        let duration: Double = Double(endTime - startTime) / Double(CLOCKS_PER_SEC)
        print("😇😇😇😇😇 duration:\(duration*1000) ms")
        self.imgView.image = UIImage(cgImage: cgImg)
        self.ciImg = CIImage(cgImage: cgImg)
        self.context.clearCaches()
    }
}

