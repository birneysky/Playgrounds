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
        let shapeView = KTVSingHeaderTShapeView(frame: CGRect(x: 30, y: 199, width: 193.5, height: 54))
        var frame = shapeView.bounds
        frame.origin.x = frame.origin.x - 8
        frame.origin.y = frame.origin.y - 8
        frame.size.width = frame.size.width + 16
        frame.size.height = frame.size.height + 16
        
        let scrollView = KTVSingHeaderBannerScrollView(frame: frame)
        scrollView.setItems([
                KTVSingBannerItem(backgroundImageName: "ktv_sing_with_past_self", iconImageName: "ktv_past_self_icon", titleText: "0001", subTitleLabel: "0001sub"),
                KTVSingBannerItem(backgroundImageName: "ktv_annual_celebration_report", iconImageName: "ktv_past_self_icon", titleText: "0002", subTitleLabel: "0002sub"),
                KTVSingBannerItem(backgroundImageName: "ktv_annual_celebration_report", iconImageName: "ktv_past_self_icon", titleText: "0003", subTitleLabel: "0003sub"),
            ])
        shapeView.addSubview(scrollView)
        shapeView.backgroundColor = .red
        
        self.view.addSubview(shapeView)
    }


}

