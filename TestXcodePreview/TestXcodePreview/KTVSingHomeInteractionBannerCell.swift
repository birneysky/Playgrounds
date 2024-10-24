//
//  KTVSingHomeInteractionBannerCell.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/10/22.
//

import UIKit

class KTVSingHomeInteractionBannerCell: FSPagerViewCell, UIGestureRecognizerDelegate {

    @IBOutlet weak var portraitBanner: KTVHeartBeatSingPortraitBanner!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var firstView: UIView!
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
        var tapGesture = UITapGestureRecognizer(target: self, action: #selector(firstViewTap(_:)))
        tapGesture.cancelsTouchesInView = false
        //tapGesture.delegate = self
        self.firstView.addGestureRecognizer(tapGesture)
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(secondViewTap(_:)))
        tapGesture.cancelsTouchesInView = false
        //tapGesture.delegate = self
        self.secondView.addGestureRecognizer(tapGesture)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(thirdViewTap(_:)))
        tapGesture.cancelsTouchesInView = false
        //tapGesture.delegate = self
        self.thirdView.addGestureRecognizer(tapGesture)
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(speakerSettingViewTap(_:)))
        tapGesture.cancelsTouchesInView = false
        //tapGesture.delegate = self
        self.speakerSettingView.addGestureRecognizer(tapGesture)
        
        self.portraitBanner.icons = ["avatar1", "avatar2", "avatar3","child", "cup", "member", "like_test"]
    }
    
    /// 允许多个手势同时识别
      func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
          return true
      }
    
    @objc func firstViewTap(_ sender: UITapGestureRecognizer) {
        print("first viewtapped")
//        if let collectionView = collectionView, let indexPath = indexPath {
//                collectionView.delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
//            }
    }
    
    @objc func secondViewTap(_ sender: UITapGestureRecognizer) {
        print("second viewtapped")
//        if let collectionView = collectionView, let indexPath = indexPath {
//                collectionView.delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
//            }
    }
    
    @objc func thirdViewTap(_ sender: UITapGestureRecognizer) {
        print("third viewtapped")
//        if let collectionView = collectionView, let indexPath = indexPath {
//                collectionView.delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
//            }
    }
    
    @objc func speakerSettingViewTap(_ sender: UITapGestureRecognizer) {
        print("speakerSetting viewtapped")
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
