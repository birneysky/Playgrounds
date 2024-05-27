//
//  KTVEntranceItemView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/4/23.
//

import UIKit


@objc protocol KTVEntranceItem {
    @objc var title: String { get }
    @objc var subTitle: String { get }
    @objc var icons: [String] { get }
    @objc var URL: String { get }
    @objc var type: Int { get }
}

class KTVAEntranceItem: KTVEntranceItem {
    var title: String
    var subTitle: String
    var icons: [String]
    var URL: String
    var type: Int
    init(title: String, subTitle: String, icons: [String], URL: String, type: Int) {
        self.title = title
        self.subTitle = subTitle
        self.icons = icons
        self.URL = URL
        self.type = type
    }
}

class KTVEntranceItemView: UIView {

    @IBOutlet weak var container: KTVHEqualSpacingContainer!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        addGestureRecognizer(tapGesture)
    }

    func setData(_ item: KTVEntranceItem? ) {
        guard let aItem = item else { return }
        self.title.text = aItem.title
        self.subTitle.text = aItem.subTitle
        aItem.icons.forEach { icon in
            let imageView = UIImageView()
            imageView.image = UIImage(named: icon)
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 28),
                imageView.heightAnchor.constraint(equalToConstant: 28)
            ])
            container.appendView(imageView)
        }
        if aItem.type == 2 {
            container.spaceing = -6
        } else {
            container.spaceing = 2
        }
    }
    
//    override var intrinsicContentSize: CGSize {
//        let containerSize = container.intrinsicContentSize
//        let titleSize = self.title.intrinsicContentSize
//        let subTitleSize = self.subTitle.intrinsicContentSize
//        let titleMaxWidth = max(titleSize.width, subTitleSize.width)
//        let width = 6 + titleMaxWidth + 4 + containerSize.width + 6
//        return CGSize(width: width, height: 40)
//    }
    
    override var intrinsicContentSize: CGSize {
        return self.bounds.size
    }
    
    @objc func tap() {
        print("xxxx")
    }

}

#Preview("KTVEntranceItemView1", traits: .portrait) {
    let view = KTVEntranceItemView.view()
    view.frame = CGRect(x: 0, y: 0, width: 90, height: 40)
    let item = KTVAEntranceItem(title: "成就榜", subTitle: "No.9999", icons: ["cup"], URL: "", type: 1)
    view.setData(item)
    return view
}

#Preview("KTVEntranceItemView2", traits: .portrait) {
    let view = KTVEntranceItemView.view()
    let item = KTVAEntranceItem(title: "礼物墙", subTitle: "9999 个", icons: ["like_test", "cup"], URL: "", type: 1)
    view.setData(item)
    return view
}

#Preview("KTVEntranceItemView3", traits: .portrait) {
    let view = KTVEntranceItemView.view()
    let item = KTVAEntranceItem(title: "超级粉丝", subTitle: "9999.99 w 位", icons: ["avatar1", "avatar2", "avatar3"], URL: "", type: 2)
    view.setData(item)
    return view
}





