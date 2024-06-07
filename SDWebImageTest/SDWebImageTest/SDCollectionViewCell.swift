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
//        SDWebImageManager.shared.loadImage(with: URL(string: url), options: [.progressiveLoad], context: [SDWebImageContextOption.imageThumbnailPixelSize : CGSize(width: 200, height: 200)]) { receivedSize, exceptedSize, url in
//            NSLog("url:\(String(describing: url)), receivedSize:\(receivedSize), exceptedSize:\(exceptedSize)")
//        } completed: {image, data, error, cacheType, finished, url in
//            self.imageView.image = image
//        }

//        SDWebImageManager.shared.loadImage(with: URL(string: url)) { receivedSize, exceptedSize, url in
//            NSLog("url:\(String(describing: url)), receivedSize:\(receivedSize), exceptedSize:\(exceptedSize)")
//        } completed: { image, data, error, cacheType, finished, url in
//            self.imageView.image = image
//        }

//        imageView.sd_setImage(with: URL(string: url)) { [weak self] image, err, cacheType, url in
//           // self?.imageView.image = image
//        }
        
        //imageView.sd_setImage(with: URL(string: url), placeholderImage: nil )
        let b = CFAbsoluteTime()
        imageView.sd_setImage(with: URL(string: url), placeholderImage: nil,options:[.progressiveLoad], context: [SDWebImageContextOption.imageThumbnailPixelSize : CGSize(width: 160, height: 160)]) {receivedSize, exceptedSize, url in
            NSLog("url:\(String(describing: url)), receivedSize:\(receivedSize), exceptedSize:\(exceptedSize)")
        } completed: { image, err, cacheType, url in
            let e = CFAbsoluteTime()
            NSLog("#################### \(String(describing: url)), \(e - b)")
        }

    }
}
