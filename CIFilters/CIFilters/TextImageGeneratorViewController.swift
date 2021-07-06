//
//  TextImageGeneratorViewController.swift
//  CIFilters
//
//  Created by birneysky on 2021/7/6.
//  Copyright © 2021 COOL. All rights reserved.
//

import UIKit

class TextImageGeneratorViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var time: Timer!
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let filter = CIFilter(name: "CITextImageGenerator") else {
            return;
        }
        
        print(filter.attributes)
  
        
        var count: Int = 0;
        self.time = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            filter.setValue(NSString.init(format: "%010d", count), forKey: "inputText")
            guard let outImg = filter.outputImage else {
                return;
            }
            let img = UIImage(ciImage: outImg)
            //print(img.size)
            
            self.imageView.image = img
            
            count += 1
        }
        self.time.fire()
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
