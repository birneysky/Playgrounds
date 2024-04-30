//
//  KTVPluginItemView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/4/24.
//

import UIKit


@objc protocol KTVPluginItem {
    @objc var title: String { get }
    @objc var icon: String { get }
    @objc var redirectURL: String { get }
    @objc var bageText: String? { get }
    @objc var type: Int { get }
}


class KTVAPluginItem: KTVPluginItem {
    
    var title: String
    var icon: String
    var redirectURL: String
    var type: Int
    var bageText: String?
    
    init(title: String, icon: String, redirectURL: String, type: Int, bageText: String?) {
        self.title = title
        self.icon = icon
        self.redirectURL = redirectURL
        self.type = type
        self.bageText = bageText
    }
}

class KTVPluginItemView: UIView {
    @IBOutlet weak var bageView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bageLabel: UILabel!
    @IBOutlet weak var bageBackgroundImageView: UIImageView!
    var data: KTVPluginItem?
    override var intrinsicContentSize: CGSize {
        let width = self.titleLabel.intrinsicContentSize.width
        return CGSize(width: width, height: 54)
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        let resizeImage = UIImage(named: "ktv_personal_page_plugin_item_bage_bg")?.resizableImage(withCapInsets: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8), resizingMode: .tile)
        bageBackgroundImageView.image = resizeImage
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        addGestureRecognizer(tapGesture)
    }
    
    func setData(_ item: KTVPluginItem? ) {
        data = item
        guard let aItem = item else { return }
        titleLabel.text = aItem.title
        imageView.image = UIImage(named: aItem.icon)
        bageLabel.text = aItem.bageText
        self.bageView.isHidden = aItem.bageText?.count ?? 0  <=  0
    }
    
    @objc func tap() {
        guard let aItem = data else { return }
        print("jum to \(aItem.redirectURL)")
    }
}


#Preview("KTVPluginItemView", traits: .portrait) {
    let view = KTVPluginItemView.view()
    view.setData(KTVAPluginItem(title: "我的大爷", icon: "cup", redirectURL: "changba://你/我/啊", type: 1, bageText: "哈哈哈"))
    return view
}
