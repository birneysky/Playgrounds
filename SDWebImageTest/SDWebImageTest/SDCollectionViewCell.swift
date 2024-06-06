//
//  SDCollectionViewCell.swift
//  SDWebImageTest
//
//  Created by Bruce on 2024/6/6.
//

import UIKit
import SDWebImage

class SDCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: SDAnimatedImageView!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    func setURL(_ url: String) {
//        imageView.sd_setImage(with: URL(string: url))
        imageView.sd_setImage(with: URL(string: url)) { [weak self] image, err, cacheType, url in
           // self?.imageView.image = image
        }
        
        //imageView.sd_setImage(with: URL(string: url), placeholderImage: nil )
    }
}
