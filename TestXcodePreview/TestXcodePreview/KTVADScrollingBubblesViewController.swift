//
//  KTVADScrollingBubblesViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/5/28.
//

import UIKit

class KTVADScrollingBubblesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x: 0, y: 0, width: 60, height: 76)
        let banner = KTVHorizontalScrollingBanner<KTVBannerItem, KTVBannerItemView>(frame: frame)
        banner.items = [
            KTVBannerItem(KTVBannerModel(imageURL: "0001", time: 86_400 * 2 + 7200 * 2, redirectURL: "xxx")),
            KTVBannerItem(KTVBannerModel(imageURL: "0005", redirectURL: "xxx")),
            KTVBannerItem(KTVBannerModel(imageURL: "0003", time: 86_400 * 3 + 8900 * 2, redirectURL: "xxx")),
        ]
        self.view.addSubview(banner)
    }

    @IBAction func closeAction(_ sender: UIButton) {
        self.view.removeFromSuperview()
        self.removeFromParent()
        print("hahahah")
    }
}


@available(iOS 17.0, *)
#Preview("KTVHorizontalScrollingBannerA", traits: .portrait) {
    let parentController = UIViewController()
    parentController.view.backgroundColor = .red
    let controller = KTVADScrollingBubblesViewController.controller()
    parentController.addChild(controller)
    parentController.view.addSubview(controller.view)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        controller.view.centerYAnchor.constraint(equalTo: parentController.view.centerYAnchor),
        controller.view.centerXAnchor.constraint(equalTo: parentController.view.centerXAnchor),
        controller.view.widthAnchor.constraint(equalToConstant: 60),
        controller.view.heightAnchor.constraint(equalToConstant: 76),
    ])
    return parentController;
    
}
