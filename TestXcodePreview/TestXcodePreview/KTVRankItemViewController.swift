//
//  KTVAchievementEntranceViewController.swift
//  ktv
//
//  Created by Bruce on 2024/4/23.
//

import UIKit


@objc class KTVRankItemViewController: UIViewController {

    @IBOutlet weak var itemContainer: UIStackView!
    var items: [KTVEntranceItem] = [
        KTVAEntranceItem(title: "成就榜", subTitle: "No.9999", icons: ["cup"], URL: "", type: 1),
        KTVAEntranceItem(title: "礼物墙", subTitle: "9999 个", icons: ["like_test", "cup"], URL: "", type: 1),
        KTVAEntranceItem(title: "超级粉丝", subTitle: "9999 位", icons: ["avatar1", "avatar2", "avatar3"], URL: "", type: 2),
//        KTVAEntranceItem(title: "超级粉丝", subTitle: "9999 位", icons: ["avatar1", "avatar2", "avatar3"], URL: "", type: 2),
    ]
   
    var totalWithOfFirstThreeItems: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let maxcount = min(items.count, 3)
        
        for i in 0 ..< maxcount {
            let view = KTVEntranceItemView.view()
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
            let item = items[i]
            view.setData(item)
            if i < 3 {
                totalWithOfFirstThreeItems += view.intrinsicContentSize.width
            }
            itemContainer.addArrangedSubview(view)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let width = self.view.bounds.size.width -  CGFloat(16 * 2 + 6 * 2)
        let rations = [0.248, 0.35, 0.402]
        for i in 0 ..< itemContainer.arrangedSubviews.count {
            let view = itemContainer.arrangedSubviews[i]
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 40),
                view.widthAnchor.constraint(equalToConstant: width * rations[i])
            ])
        }
        itemContainer.spacing = 6
//        if items.count >= 3 {
//            let width = self.view.bounds.size.width -  CGFloat(totalWithOfFirstThreeItems + 16 * 2)
//            let spacing =  max(width /  CGFloat(items.count - 1),4.0)
//            itemContainer.spacing = spacing
//            print("spacing: \(spacing)")
//        } else {
//            itemContainer.spacing = 6
//        }
    }
}


@available(iOS 17.0, *)
#Preview{
    let parentController = UIViewController()
    let controller = KTVRankItemViewController.controller()
    parentController.addChild(controller)
    parentController.view.addSubview(controller.view)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        controller.view.centerYAnchor.constraint(equalTo: parentController.view.centerYAnchor),
        controller.view.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor),
        controller.view.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor),
        controller.view.heightAnchor.constraint(equalToConstant: 40),
    ])
    return parentController;
}
