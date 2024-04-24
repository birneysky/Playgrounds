//
//  KTVAchievementEntranceViewController.swift
//  ktv
//
//  Created by Bruce on 2024/4/23.
//

import UIKit





class KTVAchievementEntranceViewController: UIViewController {

    @IBOutlet weak var itemContainer: UIStackView!
    var items: [KTVEntranceItem] = [
        KTVAEntranceItem(title: "成就榜", subTitle: "No.9999", icons: ["cup"], URL: "", type: 1),
        KTVAEntranceItem(title: "礼物墙", subTitle: "9999 个", icons: ["like_test", "cup"], URL: "", type: 1),
        KTVAEntranceItem(title: "超级粉丝", subTitle: "9999 位", icons: ["avatar1", "avatar2", "avatar3"], URL: "", type: 2),
        KTVAEntranceItem(title: "超级粉丝", subTitle: "9999 位", icons: ["avatar1", "avatar2", "avatar3"], URL: "", type: 2),
    ]
    
    var totalWithOfFirstThreeItems: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for i in 0 ..< items.count {
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
        if items.count >= 3 {
            var totalItemWidth: CGFloat = 0
            for i in 0 ..< 3 {
                totalItemWidth = totalItemWidth + itemContainer.arrangedSubviews[i].bounds.size.width
            }
            let width = self.view.bounds.size.width -  CGFloat(totalWithOfFirstThreeItems + 16 * 2)
            let spacing =  width /  2.0
            itemContainer.spacing = spacing
        }
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


#Preview {
    let parentController = UIViewController()
    let controller = KTVAchievementEntranceViewController(nibName: "KTVAchievementEntranceViewController", bundle: nil)
    parentController.addChild(controller)
    parentController.view.addSubview(controller.view)
    //controller.view.backgroundColor = .red
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        controller.view.centerYAnchor.constraint(equalTo: parentController.view.centerYAnchor),
        controller.view.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor),
        controller.view.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor),
        controller.view.heightAnchor.constraint(equalToConstant: 40),
    ])
    return parentController;
}
