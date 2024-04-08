//
//  ViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/1/5.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        var v = BannerView(frame: .init(x: 50, y: 100, width: 300, height: 100))
//        v.backgroundColor = .gray
        //view.cornerSize = 32
        //view.backgroundColor = .systemPink
        let v = MCInfiniteScrollView(frame: CGRect(x: 50, y: 100, width: 300, height: 100))
        self.view.addSubview(v)
    }


}

