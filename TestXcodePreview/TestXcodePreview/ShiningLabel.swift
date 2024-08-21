//
//  ShinningLabel.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/8/6.
//

import UIKit

class ShiningLabel: UILabel {
    
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        textLayer.frame = bounds
        textLabel.frame = bounds
        updateTextLayer()
        
    }
    
    private func updateTextLayer() {
        textLayer.string = text
        textLayer.font = font
        textLayer.fontSize = font.pointSize
        textLayer.alignmentMode = alignmentMode(from: textAlignment)
        textLayer.contentsScale = UIScreen.main.scale
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
    private let textLayer = CATextLayer()
    private let textLabel = UILabel()
    override var intrinsicContentSize: CGSize {
        //self.bounds.size
        return calculateTextLayerSize()
    }
    

}


#Preview("ShiningLabel1") {
    let view  = ShiningLabel(gradientColors: [
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
    view.text = "💦💦川仔端茶又倒水川仔端茶又倒水"
    view.font = UIFont.systemFont(ofSize: 17)
    return view
}

#Preview("ShiningLabel2") {
    let view  = ShiningLabel(gradientColors: [
        rgba("#CA7D00FF"),
        rgba("#CA7D00FF"),
        rgba("#FFEB01FF"),
        rgba("#FFEB01FF"),
        rgba("#CA7D00FF"),
        rgba("#CA7D00FF"),
    ], locations: [
        0, 0.34, 0.37, 0.48, 0.5, 1
    ], startPoint: CGPoint(x: 0, y: 0.3),
        endPoint: CGPoint(x: 1, y: 0.5))
    view.text = "🌤️川仔端茶又倒水川仔端茶又倒水"
    view.font = UIFont.systemFont(ofSize: 17)
    return view
}

#Preview("ShiningLabel3") {
    let view  = ShiningLabel(gradientColors: [
        rgba("#DA9F06FF"),
        rgba("#05BA63FF"),
        rgba("#2028DDFF"),
        rgba("#FFEB01FF"),
        rgba("#F82F3DFF")
    ], locations: [
        0, 0.33, 0.67, 0.48, 1
    ], startPoint: CGPoint(x: 0, y: 0.5),
       endPoint: CGPoint(x: 1, y: 0.5))
    view.text = "🌤️🥶☠️川仔端茶又倒水川仔端茶又倒水"
    view.font = UIFont.systemFont(ofSize: 17)
    return view
}


#Preview("ShiningLabel5") {
    let startPoint = CGPoint(x: 0, y: 0)
    let endPoint = CGPoint(x: startPoint.x + cos(80 * .pi / 180), y: startPoint.y + sin(80   * .pi / 180))
    let view  = ShiningLabel(gradientColors: [
        .blue,
        .white,
        .white,
        .blue

    ], locations: [
        0, 0.45, 0.55,  1
    ], startPoint: startPoint,
                             endPoint: endPoint)
    view.text = "川😇😜💔💓💟🌤️🌤️"
    view.font = UIFont.systemFont(ofSize: 32)
    view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    return view
}
