//
//  KTVLRCompeteRedPacketView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/6/17.
//

import UIKit

class KTVLRCompeteRedPacketView: UIView {

    @IBOutlet weak var button: UIButton!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 243, height: 327)
    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        
        // 创建属性化字符串
        let attributedTitle = NSMutableAttributedString()

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 4
        // "去评论" 部分
        let firstPart = "去评论\n"
        
        
        let firstAttributes: [NSAttributedString.Key: Any] = [
           .font: UIFont.systemFont(ofSize: 17),
           .foregroundColor: UIColor(red: 231/255.0, green: 11/255.0, blue: 21/255.0, alpha: 1.0),
           .paragraphStyle: paragraphStyle
        ]
        let firstAttributedString = NSAttributedString(string: firstPart, attributes: firstAttributes)
        attributedTitle.append(firstAttributedString)

        // "抢红包" 部分
        let secondPart = "抢红包"
        let secondAttributes: [NSAttributedString.Key: Any] = [
           .font: UIFont.systemFont(ofSize: 12),
           .foregroundColor: UIColor(red: 231/255.0, green: 11/255.0, blue: 21/255.0, alpha: 1.0),
           .paragraphStyle: paragraphStyle
        ]
        let secondAttributedString = NSAttributedString(string: secondPart, attributes: secondAttributes)
        attributedTitle.append(secondAttributedString)
               
               // 设置按钮的属性化标题
        self.button.setAttributedTitle(attributedTitle, for: .normal)
               
               // 居中对齐
        self.button.titleLabel?.textAlignment = .center
           //button.titleLabel?.numberOfLines = 0
    }

}


#Preview("KTVPluginItemView", traits: .portrait) {
    let view = KTVLRCompeteRedPacketView.view()
    return view
}
