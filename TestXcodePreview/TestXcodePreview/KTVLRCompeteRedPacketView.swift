//
//  KTVLRCompeteRedPacketView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/6/17.
//

import UIKit

class KTVLRCompeteRedPacketView: UIView {

    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var conditionTipLabel: UILabel!
    @IBOutlet weak var numPersonLabel: UILabel!
    @IBOutlet weak var numRedPacketLabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var tap: ((String)->Void)?
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 243, height: 327)
    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        
        let attributedTitle = NSMutableAttributedString()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 4
        let firstPart = "去评论\n"
                
        let firstAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
           .foregroundColor: rgba("#E70B15FF"),
           .paragraphStyle: paragraphStyle
        ]
        let firstAttributedString = NSAttributedString(string: firstPart, attributes: firstAttributes)
        attributedTitle.append(firstAttributedString)

        let secondPart = "抢红包"
        let secondAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12, weight: .medium),
           .foregroundColor: rgba("#E70B15FF"),
           .paragraphStyle: paragraphStyle
        ]
        let secondAttributedString = NSAttributedString(string: secondPart, attributes: secondAttributes)
        attributedTitle.append(secondAttributedString)
               
        self.button.setAttributedTitle(attributedTitle, for: .normal)
        self.button.titleLabel?.textAlignment = .center
    }

}


#Preview("KTVLRCompeteRedPacketView", traits: .portrait) {
    let view = KTVLRCompeteRedPacketView.view()
    return view
}
