//
//  KTVBannerItemViewB.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/5/22.
//

import UIKit

struct ItemB: KTVBannerItemData {
    typealias T = ItemB
    var data: ItemB? {
        return self
    }
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


class KTVBannerItemViewB: UIView, KTVBannerDataConfigurable {
    @IBOutlet weak var label: UILabel!
    static func createView() -> Self {
        return KTVBannerItemViewB.view() as! Self
    }
    
    typealias T = ItemB
    func setData(_ data: ItemB?) {
        guard let item = data else { return }
        label.text = item.titleText
    }
}
