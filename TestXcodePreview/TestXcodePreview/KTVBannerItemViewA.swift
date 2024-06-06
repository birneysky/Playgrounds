//
//  KTVBannerItemViewA.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/5/22.
//

import UIKit

struct ItemA: KTVBannerItemData {
    typealias T = ItemA
    var data: ItemA? {
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

class KTVBannerItemViewA: UIView, KTVBannerDisplayable {
    @IBOutlet weak var label: UILabel!
    typealias T = ItemA
    func setData(_ data: ItemA?) {
        guard let item = data else { return }
        label.text = item.titleText
    }
}

