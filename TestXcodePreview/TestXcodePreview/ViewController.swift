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
        
        
        self.view.backgroundColor = .white
        let viewx = KTVScaleLineView(frame: CGRect(x: 0, y: 500, width: 397, height: 104),
                                     style: .begin,
                                     startTime: 10000,
                                     endTime: 20000,
                                     firstLyric: "尽管讲出不快吧",
                                     secondLyric: "仍然紧守于身边")
        self.view.addSubview(viewx)
        
//        let views  = ShiningLabel(gradientColors: [
//            rgba("#CA7D00FF"),
//            rgba("#CA7D00FF"),
//            rgba("#FFEB01FF"),
//            rgba("#FFEB01FF"),
//            rgba("#CA7D00FF"),
//            rgba("#CA7D00FF"),
//        ], locations: [
//            0, 0.34, 0.37, 0.48, 0.5, 1
//        ], startPoint: CGPoint(x: 0, y: 0.5),
//         endPoint: CGPoint(x: 1, y: 0.5))
//        views.text = "💦💦川仔端茶又倒水川仔端茶又倒水"
//        views.font = UIFont.systemFont(ofSize: 17)
//        view.frame = CGRect(x: 0, y: 100, width: 397, height: 104)
//        self.view.addSubview(views)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let layout = UICollectionViewFlowLayout()
//            layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//            layout.estimatedItemSize = CGSizeMake(44, 44)
//        let controller = TestCollectionViewController(collectionViewLayout: layout)
//        self.present(controller, animated: true)
        
        
//        let parentController = UIViewController()
//        parentController.view.backgroundColor = .black
//        let controller = KTVLRWinRedPacketViewController.controller()
//        parentController.addChild(controller)
//        parentController.view.addSubview(controller.view)
//        controller.view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            controller.view.centerXAnchor.constraint(equalTo: parentController.view.centerXAnchor),
//            controller.view.centerYAnchor.constraint(equalTo: parentController.view.centerYAnchor),
//            controller.view.widthAnchor.constraint(equalToConstant: 243),
//            controller.view.heightAnchor.constraint(equalToConstant: 391),
//        ])
//        self.present(parentController, animated: true)
        
        
//        let webcv = WKWebViewController.controller()
//        self.present(webcv, animated: true)
        
        
//        let controller = KTVGussUSearchViewController.controller()
//        self.present(controller, animated: true)
        
        
//        let view = KTVHeartBeatSingPortraitBanner(frame: CGRect(x: 100, y: 100, width: 80, height: 32))
//        view.avatars = ["avatar1", "avatar2",]
//        //view.icons = ["avatar1", "avatar2", "avatar3"]
//        //view.icons = ["avatar1", "avatar2", "avatar3","child"]
//        view.backgroundColor = .red
//        self.view.addSubview(view)
        
        
//        let view = KTVHeartBeatSingPortraitBanner3()
//        view.avatars = ["avatar1", "avatar2", "avatar3","child", "cup", "member", "like_test"]
//        view.backgroundColor = .red
//        view.clipsToBounds = false
//        view.frame = CGRect(x: 100, y: 200, width: 90, height: 32)
//        self.view.addSubview(view)
//        view.center = self.view.center
        
        
//        let parentController = UIViewController()
//        parentController.view.backgroundColor = .white
//        let controller = KTVGussUSearchViewController.controller()
//        controller.view.backgroundColor = .blue
//        parentController.addChild(controller)
//        parentController.view.addSubview(controller.view)
//        self.present(parentController, animated: true)
        
        
        let shiningLabel  = KTVShiningEffectLabel1()
        let effect = KTVNickNameEffectModel()
         effect.darkColors = ["#CA7D00FF", "#CA7D00FF", "#FFEB01FF",
                              "#FFEB01FF", "#CA7D00FF","#CA7D00FF"]
         effect.lightColors = ["#CA7D00FF", "#CA7D00FF", "#FFEB01FF",
                               "#FFEB01FF", "#CA7D00FF","#CA7D00FF"]
         effect.positions = [0, 0.34, 0.37, 0.48, 0.5, 1]
         effect.duration = 2.5
         effect.degree = 10
        shiningLabel.setEffect(effect)
        shiningLabel.text = "𒈔wh3🙈🐸名词😅哦👿👿公民-------------------"
        shiningLabel.font = UIFont.systemFont(ofSize: 16)
        shiningLabel.textColor = .black
        shiningLabel.backgroundColor = .blue
         
         let  imageView = UIImageView()
         imageView.image = UIImage(named: "ktv_svip_tips_icon")
         NSLayoutConstraint.activate([
             imageView.widthAnchor.constraint(equalToConstant: 28),
             view.heightAnchor.constraint(equalToConstant: 16),
         ])
         let stackView1 = UIStackView()
        stackView1.axis  = .horizontal
        stackView1.alignment = .center
        stackView1.distribution = .fill
        stackView1.spacing = 4
        stackView1.addArrangedSubview(shiningLabel)
        stackView1.addArrangedSubview(imageView)
        self.view.addSubview(stackView1);
        //stackView1.frame = CGRect(x: 0, y: 200, width: 220, height: 30)
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView1.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -16),
            stackView1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            stackView1.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 350),
            //stackView1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 800)
        ])
        self.view.layoutIfNeeded()
        
        
        
        let pcd = WatchViewController()
        self.present(pcd, animated: true)
    }
}

