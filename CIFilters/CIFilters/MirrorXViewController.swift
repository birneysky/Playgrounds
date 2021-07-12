//
//  MirrorXViewController.swift
//  CIFilters
//
//  Created by Bruce on 2021/7/11.
//  Copyright © 2021 COOL. All rights reserved.
//

import UIKit

class MirrorXViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var mirrorFilter: MirrorXFilter!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let klara = UIImage(named: "klara")?.cgImage else {
            return
        }
        let inputImg = CIImage(cgImage: klara)
        mirrorFilter = MirrorXFilter()
        mirrorFilter.inputImage = inputImg
        guard let outImg =  mirrorFilter.outputImage else {
            return;
        }
        print(outImg)
        self.imageView.image = UIImage(ciImage: outImg)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
