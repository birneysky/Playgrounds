//
//  KTVPluginItemsViewController.swift
//  ktv
//
//  Created by Bruce on 2024/4/23.
//

import UIKit


@objc class KTVPluginItemsViewController: UIViewController {

    @IBOutlet weak var itemContainer: UIStackView!
    var items: [KTVPluginItem] = [
        KTVAPluginItem(title: "我的包房", icon: "ktv_room", redirectURL: "changba://我的包房", type: 1, bageText: "哈"),
        KTVAPluginItem(title: "活动中心", icon: "vip", redirectURL: "changba://活动中心", type: 1, bageText: "好多福利"),
        KTVAPluginItem(title: "会员中心", icon: "member", redirectURL: "changba://会员中心", type: 1, bageText: "换积分"),
        KTVAPluginItem(title: "至尊特权", icon: "race", redirectURL: "changba://至尊特权", type: 1, bageText: nil),
        KTVAPluginItem(title: "我的群组", icon: "my_group", redirectURL: "changba://我的群组", type: 1, bageText: nil),
        KTVAPluginItem(title: "赛事中心", icon: "cup", redirectURL: "changba://赛事中心", type: 1, bageText: ""),
    ]
   
    var totalWithOfFirstThreeItems: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0 ..< items.count {
            let view = KTVPluginItemView.view()
            let item = items[i]
            view.setData(item)
            if i < 5 {
                totalWithOfFirstThreeItems += view.intrinsicContentSize.width
            }
            itemContainer.addArrangedSubview(view)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if items.count >= 5 {
            let width = self.view.bounds.size.width -  CGFloat(totalWithOfFirstThreeItems + 16 * 2)
            let spacing =  width /  (5 - 1)
            itemContainer.spacing = spacing
        } else {
            itemContainer.spacing = 23
        }
    }
}


#Preview {
    let parentController = UIViewController()
    let controller = KTVPluginItemsViewController.controller()
    parentController.addChild(controller)
    parentController.view.addSubview(controller.view)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        controller.view.centerYAnchor.constraint(equalTo: parentController.view.centerYAnchor),
        controller.view.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor),
        controller.view.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor),
        controller.view.heightAnchor.constraint(equalToConstant: 54),
    ])
    return parentController;
}
