//
//  KTVSingHomeInteractionBannerCell.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/10/22.
//

import UIKit

class KTVSingHomeInteractionBannerCell: FSPagerViewCell {

    @IBOutlet weak var secondBackgroundImageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdBackgroundImageView: UIImageView!
    @IBOutlet weak var secondBackgroudImageView: UIImageView!
    @IBOutlet weak var firstBackgroundImageView: UIImageView!
    @IBOutlet weak var speakerSettingContainer: UIStackView!
    @IBOutlet var speakerSettingView: UIView!
    @IBOutlet weak var thirdViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstViewWidthConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.contentView.backgroundColor = .red

    }
    
    
    func hahah() {
//        UIView.animate(withDuration: 0.35, delay: 2) {
            if self.speakerSettingView.superview != nil {
                self.speakerSettingView.removeFromSuperview()
                self.firstViewWidthConstraint.constant = 175
                self.secondViewWidthConstraint.constant = 174
                self.thirdViewWidthConstraint.constant = 174
               
                self.secondBackgroundImageViewLeadingConstraint.constant = 8
                self.thirdBackgroundImageView.image = UIImage(named: "ktv_sing_home_header_third_big")
                self.secondBackgroudImageView.image = UIImage(named: "ktv_sing_home_header_second_big")
                self.firstBackgroundImageView.image = UIImage(named: "ktv_sing_home_header_first_big")
                
            } else {
                self.speakerSettingContainer.insertArrangedSubview(self.speakerSettingView, at: 0)
                self.firstViewWidthConstraint.constant = 133
                self.secondViewWidthConstraint.constant = 127
                self.thirdViewWidthConstraint.constant = 127
                self.thirdBackgroundImageView.image = UIImage(named: "ktv_sing_home_header_third")
                self.secondBackgroudImageView.image = UIImage(named: "ktv_sing_home_header_second")
                self.firstBackgroundImageView.image = UIImage(named: "ktv_sing_home_header_first")
            }
            self.layoutIfNeeded()
//        }
        
    }

}
