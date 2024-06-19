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
        
//        let scrollView = KTVSingHeaderBannerScrollView(frame: frame)
//        scrollView.items = [
//                KTVSingBannerItem(backgroundImageName: "ktv_sing_with_past_self", iconImageName: "ktv_past_self_icon", titleText: "0001", subTitleLabel: "0001sub"),
//                KTVSingBannerItem(backgroundImageName: "ktv_annual_celebration_report", iconImageName: "ktv_past_self_icon", titleText: "0002", subTitleLabel: "0002sub"),
//                KTVSingBannerItem(backgroundImageName: "ktv_annual_celebration_report", iconImageName: "ktv_past_self_icon", titleText: "0003", subTitleLabel: "0003sub"),
//        ]
        
        let banner = KTVHorizontalScrollingBanner<ItemA, KTVBannerItemViewA>(frame: frame)
        banner.backgroundColor = .green
        banner.items = [
            ItemA(backgroundImageName: "ktv_sing_with_past_self", iconImageName: "ktv_past_self_icon", titleText: "0001", subTitleLabel: "0001sub"),
            ItemA(backgroundImageName: "ktv_annual_celebration_report", iconImageName: "ktv_past_self_icon", titleText: "0002", subTitleLabel: "0002sub"),
            ItemA(backgroundImageName: "ktv_annual_celebration_report", iconImageName: "ktv_past_self_icon", titleText: "0003", subTitleLabel: "0003sub"),
        ]
        shapeView.addSubview(banner)
        shapeView.backgroundColor = .red
        
        self.view.addSubview(shapeView)
        
        
        let parentView = UIView(frame: CGRect(x: 50, y: 100, width: 200, height: 40))
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 8 // 您可以根据需要调整间距
        parentView.backgroundColor = .purple
        // 添加 ImageView 到 stackView
        for _ in 0..<3 {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height:    28))
            imageView.contentMode = .scaleAspectFit
            imageView.backgroundColor = .red
            stackView.addArrangedSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 28),
                imageView.heightAnchor.constraint(equalToConstant: 28)
            ])
        }

        parentView.addSubview(stackView)
        // 设置 stackView 的约束
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        stackView.topAnchor.constraint(equalTo: parentView.topAnchor),
        stackView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
        //stackView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
        stackView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 8),
        stackView.trailingAnchor.constraint(lessThanOrEqualTo: parentView.trailingAnchor)
        ])
        parentView.layoutIfNeeded()
        self.view.addSubview(parentView)
        
        let view = KTVHEqualSpacingContainer()
        view.backgroundColor = .blue
        self.view.addSubview(view)
        
        let tview = KTVEntranceItemView.view()
        let item = KTVAEntranceItem(title: "成就榜", subTitle: "xxxx", icons: ["avatar1", "avatar2", "avatar3"], URL: "", type: 1)
        tview.setData(item)
        self.view.addSubview(tview)
        tview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            tview.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
    
        let controller = KTVRankItemViewController.controller()
        self.addChild(controller)
        self.view.addSubview(controller.view)
        controller.view.backgroundColor = .blue
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            controller.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            controller.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            controller.view.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        
        
        let f = CGRect(x: 0, y: 300, width: 60, height: 76)
        let bannerx = KTVHorizontalScrollingBanner<KTVBannerItem, KTVBannerItemView>(frame: f)
        bannerx.backgroundColor = .green
        
        bannerx.items = [
            KTVBannerItem(KTVBannerModel(imageURL: "", time: 8999, redirectURL: "xxx"))
        ]
        self.view.addSubview(bannerx)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let layout = UICollectionViewFlowLayout()
//            layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//            layout.estimatedItemSize = CGSizeMake(44, 44)
//        let controller = TestCollectionViewController(collectionViewLayout: layout)
//        self.present(controller, animated: true)
        
        
        let parentController = UIViewController()
        parentController.view.backgroundColor = .black
        let controller = KTVLRWinRedPacketViewController.controller()
        parentController.addChild(controller)
        parentController.view.addSubview(controller.view)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            controller.view.centerXAnchor.constraint(equalTo: parentController.view.centerXAnchor),
            controller.view.centerYAnchor.constraint(equalTo: parentController.view.centerYAnchor),
            controller.view.widthAnchor.constraint(equalToConstant: 243),
            controller.view.heightAnchor.constraint(equalToConstant: 391),
        ])
        self.present(parentController, animated: true)
    }


}

