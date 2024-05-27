//
//  TestCollectionViewCell.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/5/22.
//

import UIKit

var count: Int = 0
class TestCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override var intrinsicContentSize: CGSize {
//        
//        print("---------------------- \(count)")
//        count = count + 1
//        let labelSize = self.label.intrinsicContentSize
//        return CGSize(width: labelSize.width + 16, height: labelSize.height + 16)
//    }
}
