//
//  YYCollectionViewCell.swift
//  SDWebImageTest
//
//  Created by Bruce on 2024/6/6.
//

import UIKit
import YYWebImage

class YYCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: YYAnimatedImageView!
    override  func awakeFromNib() {
        super.awakeFromNib()
        //self.imageView.autoPlayAnimatedImage = false
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
//        let b = CFAbsoluteTime()
//        imageView.sd_setImage(with: URL(string: url), placeholderImage: nil,options:[.progressiveLoad], context: [SDWebImageContextOption.imageThumbnailPixelSize : CGSize(width: 160, height: 160)]) {receivedSize, exceptedSize, url in
//            NSLog("url:\(String(describing: url)), receivedSize:\(receivedSize), exceptedSize:\(exceptedSize)")
//        } completed: { image, err, cacheType, url in
//            let e = CFAbsoluteTime()
//            NSLog("#################### \(String(describing: url)), \(e - b)")
//        }

//        let b = CFAbsoluteTimeGetCurrent()
//        // .avoidSetImage
//        imageView.yy_setImage(with: URL(string: url), placeholder: nil, options: [.showNetworkActivity, .setImageWithFadeAnimation]) { image, url, type, stage, err in
//            let e = CFAbsoluteTimeGetCurrent()
//            NSLog("################# \(e-b) \(url) ");
//        }
        

        imageView.yy_setImage(with: URL(string: url), placeholder: nil, progress: nil, transform: { img, url in
            return img;// return img.yy_image(byRoundCornerRadius: 40)
        }, completion: { img, url, type, stage, err in
            
        })
    }
   
//    override func didMoveToWindow() {
//        super.didMoveToWindow()
//        if window == nil {
//           NSLog("###############")
//        } else {
//            NSLog("**********************")
//            imageView.startAnimating()
//        }
//    }
}
