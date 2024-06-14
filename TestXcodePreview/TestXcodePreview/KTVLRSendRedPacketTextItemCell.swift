//
//  KTVLRSendRedPacketTextItemCell.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/6/14.
//

import UIKit



class KTVLRSendRedPacketTextItemCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.label.layer.cornerRadius = 14
        self.label.layer.masksToBounds = true
        self.label.backgroundColor = rgba("#FFFFFF1A")
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                label.backgroundColor = rgba("#FF334833")
                label.textColor = rgba("#FF3348FF")
            } else {
                label.backgroundColor = rgba("#FFFFFF1A")
                label.textColor = .white    
            }
        }
    }

}
