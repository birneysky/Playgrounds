//
//  KTVPartialRoundedView.swift
//  ktv
//
//  Created by Bruce on 2023/12/21.
//

import UIKit

class KTVPartialRoundedView: UIView {

    @IBInspectable var cornerSize: CGFloat = 8
    @IBInspectable var corners: UIRectCorner = [.topLeft, .topRight] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    
    override func layoutSubviews() {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerSize, height: cornerSize))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer
    }
    
    override var intrinsicContentSize: CGSize {
        return self.bounds.size
    }
}



#Preview("MLTopLRRoundedView1", traits: .landscapeRight) {
    var view = KTVPartialRoundedView(frame: .init(x: 0, y: 0, width: 300, height: 100))
    view.cornerSize = 32
    view.backgroundColor = .systemPink
    return view
}

#Preview("MLTopLRRoundedView2", traits: .portrait) {
    var view = KTVPartialRoundedView(frame: .init(x: 0, y: 0, width: 83, height: 24))
    view.clipsToBounds = true
    view.corners = [.topLeft, .bottomLeft]
    //view.cornerSize = 8
    view.cornerSize = 12
    view.backgroundColor = .clear
    let a  = KTVColorsGradientView(frame: CGRect(x: 0, y: 0, width: 83, height: 24))
    a.setColors([
        UIColor(named: "#EDC1FF8A")!,
        UIColor(named: "#FFFFFF8A")!
    ])
    a.startPoint = CGPoint(x: 0, y: 0.5)
    a.endPoint = CGPoint(x: 1, y: 0.5)

    view.addSubview(a)
    return view
}



#Preview("MLTopLRRoundedView3", traits: .portrait) {
    let frame1 = CGRect(x: 0, y: 0, width: 83, height: 24)
    var view1 = KTVPartialRoundedView(frame: frame1)
    view1.clipsToBounds = true
    view1.corners = [.topLeft, .bottomLeft]
    //view.cornerSize = 8
    view1.cornerSize = 12
    view1.backgroundColor = .clear
    let a  = KTVColorsGradientView(frame: CGRect(x: 0, y: 0, width: 83, height: 24))
    a.setColors([
        UIColor(named: "#EDC1FF8A")!,
        UIColor(named: "#FFFFFF8A")!
    ])
    a.startPoint = CGPoint(x: 0, y: 0.5)
    a.endPoint = CGPoint(x: 1, y: 0.5)
    view1.addSubview(a)
    
    
    let frame2 = CGRect(x: 4, y: 4, width: 75, height: 16)
    var view2 = KTVPartialRoundedView(frame: frame2)
    view2.clipsToBounds = true
    view2.corners = [.topLeft, .bottomLeft]
    view2.cornerSize = 11.5
    view2.backgroundColor = .clear

    
    let b  = KTVColorsGradientView(frame: view2.bounds)
    b.setColors([
        UIColor(named: "#865BFF")!,
        UIColor(named: "#D251FF")!
    ])
    b.startPoint = CGPoint(x: 0, y: 0.5)
    b.endPoint = CGPoint(x: 1, y: 0.5)
    view2.addSubview(b)
    

    view1.addSubview(view2)
    return view1
}
