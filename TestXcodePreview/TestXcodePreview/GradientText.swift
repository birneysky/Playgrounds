//
//  GradientLabel.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/3/29.
//

import UIKit

class GradientLabel: UIView {

    private lazy  var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        ///FFFF00，00FF00，FF00FF，0000FF
        ///
        
        gradientLayer.colors = [rgba("#FFFF00FF").cgColor, rgba("#00FF00FF").cgColor,
                                rgba("#FF00FFFF").cgColor, rgba("#0000FFFF").cgColor]
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }()
    
    private lazy var label: UILabel = {
       UILabel()
    }()
    
    var text: String? {
        didSet {
            //let attributeText = extractAndReplaceEmojis(in: text ?? "", with: 20)
            //self.label.attributedText = attributeText
            self.label.text = text
            self.label.sizeToFit()
        }
    }
    
    var font: UIFont? {
        didSet {
            self.label.font = font
            self.label.sizeToFit()
        }
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var frontImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(gradientLayer)
        self.addSubview(label)
        var images = [UIImage]()
        for i in 0 ..< 95 {
            let name = String(format: "frame_%02d", i)
            if let iimage  = UIImage(named: name) {
                images.append(iimage)
            }
        }
        
        gradientLayer.mask = self.label.layer
        let animationImage = UIImage.animatedImage(with: images, duration: 10)
        imageView.image = animationImage
 //       addSubview(imageView)
        gradientLayer.addSublayer(imageView.layer)
        //gradientLayer.addSublayer(imageView.layer)
        //imageView.layer.mask = self.label.layer
        
        
        var frontimages = [UIImage]()
        for i in 0 ..< 95 {
            let name = String(format: "motion_frame_%02d", i)
            if let iimage  = UIImage(named: name) {
                frontimages.append(iimage)
            }
        }
        
        frontImageView.image = UIImage.animatedImage(with: frontimages, duration: 2.5)
        addSubview(frontImageView)
        
        
//        if let imagePattern = UIImage(named: "ktv_sing_with_past_self") {
//            let patternColor = UIColor(patternImage: imagePattern)
//            label.textColor = patternColor
//        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.bounds = self.label.bounds
        gradientLayer.frame = self.label.frame
        imageView.frame = self.label.frame
        frontImageView.frame = self.label.frame
    }
    
    override var intrinsicContentSize: CGSize {
        self.label.bounds.size
    }
    
    func extractAndReplaceEmojis(in text: String, with fontSize: CGFloat) -> NSAttributedString {
        // 创建一个可变的富文本字符串
        let attributedString = NSMutableAttributedString(string: "")
        
        // 正则表达式匹配 emoji
        let emojiPattern = "[\\p{Emoji}\\p{Extended_Pictographic}]"
        let regex = try! NSRegularExpression(pattern: emojiPattern, options: [])
        let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
        
        // 逐个匹配的字符串（即 emoji）
        var lastLocation = 0
        for match in matches {
            // 添加前面的非 emoji 文本部分
            let range = Range(NSRange(location: lastLocation, length: match.range.location - lastLocation), in: text)!
            let nonEmojiPart = NSAttributedString(string: String(text[range]))
            attributedString.append(nonEmojiPart)
            
            // 将 emoji 转换成 UIImage
            let emojiRange = Range(match.range, in: text)!
            let emojiString = String(text[emojiRange])
            if let emojiImage = emojiToImage(emoji: emojiString, fontSize: fontSize) {
                let attachment = NSTextAttachment()
                attachment.image = emojiImage
                
                // 调整图片大小
                let imageAspectRatio = emojiImage.size.width / emojiImage.size.height
                attachment.bounds = CGRect(x: 0, y: -2, width: fontSize * imageAspectRatio, height: fontSize)
                
                let attachmentString = NSAttributedString(attachment: attachment)
                attributedString.append(attachmentString)
            }
            
            lastLocation = match.range.location + match.range.length
        }
        
        // 添加最后的非 emoji 文本部分
        if lastLocation < text.count {
            let range = Range(NSRange(location: lastLocation, length: text.count - lastLocation), in: text)!
            let nonEmojiPart = NSAttributedString(string: String(text[range]))
            attributedString.append(nonEmojiPart)
        }
        
        return attributedString
    }

    func emojiToImage(emoji: String, fontSize: CGFloat) -> UIImage? {
        let size = CGSize(width: fontSize, height: fontSize)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        // 将 emoji 画在图片上
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: fontSize)]
        emoji.draw(in: CGRect(origin: .zero, size: size), withAttributes: attributes)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

#Preview {
    let view  = GradientLabel()
    view.text = "川仔端茶又🩷倒水川仔端茶又倒水"
    view.font = UIFont.systemFont(ofSize: 17)
    return view
}

