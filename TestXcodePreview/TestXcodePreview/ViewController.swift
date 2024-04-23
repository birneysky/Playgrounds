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
    }


}

