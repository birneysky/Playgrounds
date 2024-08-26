//
//  ShiningLabel2.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/8/12.
//

import UIKit





class KTVShiningEffectLabel: UILabel {

    private let textLayer = CATextLayer()
    private let textLayer1 = CATextLayer()
    private let gradientLayer = CAGradientLayer()
    private var colors: [UIColor]
    private var locations: [NSNumber]
    private var startPoint: CGPoint
    private var endPoint: CGPoint
 
    init(gradientColors:[UIColor], locations:[NSNumber], startPoint: CGPoint, endPoint: CGPoint) {
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.colors = gradientColors
        self.locations = locations
        super.init(frame: .zero)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        
    }
    
    private func setup() {
        // 配置渐变层
        gradientLayer.colors = self.colors.map{ $0.cgColor }
        gradientLayer.locations = self.locations
        gradientLayer.startPoint = self.startPoint
        gradientLayer.endPoint = self.endPoint
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
        
        // 设置渐变层的遮罩
        gradientLayer.mask = textLayer
        
        // 开始动画
        startAnimation()
        layer.addSublayer(textLayer1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        textLayer.frame = bounds
        textLayer1.frame = bounds
        updateTextLayer()
        
    }
    
    private func updateTextLayer() {
        textLayer.string = text
        textLayer.font = font
        textLayer.fontSize = font.pointSize
        textLayer.alignmentMode = alignmentMode(from: textAlignment)
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.truncationMode = .end
        
        textLayer1.string = createAttributedString(from: text ?? "")
        textLayer1.font = font
        textLayer1.fontSize = font.pointSize
        textLayer1.alignmentMode = alignmentMode(from: textAlignment)
        textLayer1.contentsScale = UIScreen.main.scale
        textLayer1.truncationMode = .end
    }
    
    private func alignmentMode(from textAlignment: NSTextAlignment) -> CATextLayerAlignmentMode {
        switch textAlignment {
        case .left:
            return .left
        case .right:
            return .right
        case .center:
            return .center
        case .justified:
            return .justified
        case .natural:
            return .natural
        @unknown default:
            return .natural
        }
    }
    override var text: String? {
        didSet {
            updateTextLayer()
        }
    }
    private func startAnimation() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = self.locations.map { $0.floatValue - 1 }
        animation.toValue = self.locations.map { $0.floatValue + 1 }
        animation.duration = 2
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "shimmerEffect")
    }
    private func calculateTextLayerSize() -> CGSize {
        guard let text = text, let font = font else {
            return .zero
        }
        
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        let size = attributedString.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil).size
        
        return CGSize(width: ceil(size.width), height: ceil(size.height))
    }

    override var intrinsicContentSize: CGSize {
        super.intrinsicContentSize
    }
    
    func createAttributedString(from text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)

        // Emoji Regular Expression Pattern
        let emojiPattern =  "[\\p{Emoji}\\p{Emoji_Presentation}\\p{Emoji_Modifier}\\p{Emoji_Modifier_Base}\\p{Emoji_Component}&&[^0-9]]"
        
        do {
            // Create a regex object for matching emojis
            let regex = try NSRegularExpression(pattern: emojiPattern, options: [])
            
            // Find all matches in the string
            let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
            
            // Set the default text color to red
            attributedString.addAttribute(.foregroundColor, value: UIColor.clear, range: NSRange(location: 0, length: text.utf16.count))
            attributedString.addAttribute(.font, value: self.font as Any, range: NSRange(location: 0, length: text.utf16.count))
            
            // Loop through all the matches and reset their color to default (black or system)
            for match in matches {
                print("######\(match.range)")
                attributedString.addAttribute(.foregroundColor, value: textColor as Any, range: match.range)
            }
            
        } catch {
            print("Failed to create regex: \(error)")
        }

        return attributedString
    }
}

#Preview {
    let view  = KTVShiningEffectLabel(gradientColors: [
        rgba("#CA7D00FF"),
        rgba("#CA7D00FF"),
        rgba("#FFEB01FF"),
        rgba("#FFEB01FF"),
        rgba("#CA7D00FF"),
        rgba("#CA7D00FF"),
    ], locations: [
        0, 0.34, 0.37, 0.48, 0.5, 1
    ], startPoint: CGPoint(x: 0, y: 0.5),
     endPoint: CGPoint(x: 1, y: 0.5))
    view.text = "W😇a😜L💔DE💓FF💟HIJKLM🌤️OPQ🌤️24329💦"
    view.font = UIFont.systemFont(ofSize: 14)
    view.textColor = .red
    return view
}
