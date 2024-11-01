//
//  TestGradientViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/3/1.
//

import UIKit

class TestGradientViewController: UIViewController {

    @IBOutlet weak var gradientView1: KTVColorsGradientView!
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientView1.layer.cornerRadius = 22
        gradientView1.setColors([
            UIColor(named: "#FFB2D933")!,
            UIColor(named: "#FCD5FF")!
        ])
        
    }
    
}


@available(iOS 17.0, *)
#Preview{
    let sb = UIStoryboard(name: "Main", bundle: nil)
    let controller = sb.instantiateViewController(withIdentifier: "TestGradientViewController")
    return controller;
}
