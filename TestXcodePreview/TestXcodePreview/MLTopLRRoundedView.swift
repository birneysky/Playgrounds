//
//  MLTopLRRoundedView.swift
//  ktv
//
//  Created by Bruce on 2023/12/21.
//

import UIKit

class MLTopLRRoundedView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    @IBInspectable var cornerSize: CGFloat = 8
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerSize, height: cornerSize))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer
    }
    
    override var intrinsicContentSize: CGSize {
        return self.bounds.size
    }
}



#Preview("MLTopLRRoundedView", traits: .landscapeRight) {
    var view = MLTopLRRoundedView(frame: .init(x: 0, y: 0, width: 300, height: 100))
    view.cornerSize = 32
    view.backgroundColor = .systemPink
    return view
}
