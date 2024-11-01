//
//  KTVSingBannerItemView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/4/9.
//

import UIKit

class KTVSingBannerItem: NSObject {
    var backgroundImageName: String
    var iconImageName: String
    var titleText: String
    var subTitleLabel: String
    init(backgroundImageName: String, iconImageName: String, titleText: String, subTitleLabel: String) {
        self.backgroundImageName = backgroundImageName
        self.iconImageName = iconImageName
        self.titleText = titleText
        self.subTitleLabel = subTitleLabel
    }
}


class KTVSingBannerItemView: UIView {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    
//    class func view() -> KTVSingBannerItemView {
//        let nib = UINib(nibName: "KTVSingBannerItemView", bundle: nil)
//        let view = nib.instantiate(withOwner: self, options: nil)[0] as! KTVSingBannerItemView
//        return view
//    }

    func setData(_ item: KTVSingBannerItem? ) {
        guard let aItem = item else { return }
        backgroundImageView.image = UIImage(named: aItem.backgroundImageName)
        iconImageView.image = UIImage(named: aItem.iconImageName)
        titleLabel.text = aItem.titleText
        subTitleLabel.text = aItem.subTitleLabel
    }
    
    
}


@available(iOS 17.0, *)
#Preview("KTVSingBannerItemView", traits: .portrait) {
    let view = KTVSingBannerItemView.view()
    return view
}
