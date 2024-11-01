//
//  KTVBannerItemView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/5/28.
//

import UIKit


@objc protocol KTVADBubbleItem {
    @objc var imageURL: String? { get }
    @objc var time: TimeInterval { get }
    @objc var redirectURL: String? { get }
}


class KTVBannerItem: NSObject,KTVBannerItemData {
    typealias T = KTVADBubbleItem
    var imageURL: String? {
        bubble?.imageURL
    }
    var date: TimeInterval? {
        bubble?.time
    }
    var redirectURL: String? {
        bubble?.redirectURL
    }
    
    var bubble: KTVADBubbleItem?
    
    init(_ bubbleData: KTVADBubbleItem) {
        bubble = bubbleData
    }
    
    
    var data: KTVADBubbleItem? {
        bubble
    }
}


class KTVBannerItemView: UIView, KTVBannerDisplayable {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var firstLabe2: UILabel!
    @IBOutlet weak var firstLabe3: UILabel!
    @IBOutlet weak var firstLabe4: UILabel!
    @IBOutlet weak var dateContainer: UIStackView!
    @IBOutlet weak var converImageView: UIImageView!
    typealias T = KTVADBubbleItem
    
   
    func convertSecondsToDaysAndHours(seconds: Int) -> (days: Int, hours: Int) {
        let days = seconds / 86_400
        let remainingSeconds = seconds % 86_400
        let hours = remainingSeconds / 3_600
        return (days, hours)
    }

    
    func setData(_ data: KTVADBubbleItem?) {
        guard let data = data else { return }
        imageView.image = UIImage(named: data.imageURL ?? "")
         if data.time > 0  {
             let time = convertSecondsToDaysAndHours(seconds: Int(data.time))
             firstLabel.text = "\(time.days)"
             firstLabe3.text = "\(time.hours % 10)"
             firstLabe4.text = "\((time.hours / 10) % 10)"
             dateContainer.isHidden = false
             converImageView.isHidden = false
         } else {
             dateContainer.isHidden = true
             converImageView.isHidden = true
         }
    }

}


class KTVBannerModel: KTVADBubbleItem {
    var time: TimeInterval
    var imageURL: String?
    var redirectURL: String?
    
    init(imageURL: String? = nil, time: TimeInterval = 0, redirectURL: String? = nil) {
        self.imageURL = imageURL
        self.time = time
        self.redirectURL = redirectURL
    }
    
}


@available(iOS 17.0, *)
#Preview("KTVHorizontalScrollingBannerA", traits: .portrait) {
    let frame = CGRect(x: 0, y: 0, width: 60, height: 76)
    let banner = KTVHorizontalScrollingBanner<KTVBannerItem, KTVBannerItemView>(frame: frame)
    banner.items = [
        KTVBannerItem(KTVBannerModel(imageURL: "0001", time: 7200, redirectURL: "xxx")),
        KTVBannerItem(KTVBannerModel(imageURL: "0005", redirectURL: "xxx")),
        KTVBannerItem(KTVBannerModel(imageURL: "0003", time: 7900, redirectURL: "xxx")),
    ]
    return banner
}
