//
//  KTVGradientProgessView.swift
//  ktv
//
//  Created by Bruce on 2024/1/25.
//

import UIKit

class KTVGradientProgessView: UIView {
    
    private lazy var indicatorLayer: CAGradientLayer = {
        var layer = CAGradientLayer()
        layer.colors = [
            UIColor(red: 1, green: 0.267, blue: 0.399, alpha: 1).cgColor,
            UIColor(red: 1, green: 0.262, blue: 0.572, alpha: 1).cgColor
        ]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        return layer
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    private func setupLayer() {
        layer.addSublayer(indicatorLayer)
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
    }
    
    override func layoutSubviews() {
        var frame = self.bounds
        frame.size.width = frame.size.width * progress
        indicatorLayer.frame = frame
        indicatorLayer.cornerRadius = frame.size.height / 2
        
    }
    
    override func draw(_ rect: CGRect) {
        let height = self.bounds.size.height
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: height / 2, height: height / 2))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer
    }
    
    
    var progress: CGFloat = 0 {
        didSet {
            var frame = self.bounds
            frame.size.width = frame.size.width * progress
            indicatorLayer.frame = frame
            indicatorLayer.cornerRadius = frame.size.height / 2
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return self.bounds.size
    }
}

@available(iOS 17.0, *)
#Preview{
    let view  = KTVGradientProgessView(frame: CGRect(x: 0, y: 0, width: 300, height: 6))
    view.progress = 0.8
    return view
}

