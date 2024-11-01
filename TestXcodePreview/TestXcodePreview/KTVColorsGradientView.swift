//
//  KTVColorsGradientView.swift
//  ktv
//
//  Created by Bruce on 2023/12/10.
//

import UIKit

class KTVColorsGradientView: UIControl {

    // 定义渐变层的属性
    @IBInspectable var firstColor: UIColor? = .white.withAlphaComponent(0.69)
    @IBInspectable var secondColor: UIColor? = .white.withAlphaComponent(0.29)
    @IBInspectable var thirdColor: UIColor?
    @IBInspectable var forthColor: UIColor?
    
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0) // 渐变层的起始点
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0) // 渐变层的结束点

    private lazy var colors = {
        [CGColor]()
    }()
    
    private lazy var locations: [NSNumber] = {
        [0.0, 1]
    }()
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()

    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    func setColors(_ colors: [UIColor]) {
        self.colors  = colors.map{ $0.cgColor }
    }
    
    func setLocations(_ locations: [NSNumber]) {
        self.locations = locations
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.colors.count == 0 {
            if let color = firstColor?.cgColor {
                colors.append(color)
            }
            
            if let color = secondColor?.cgColor {
                colors.append(color)
            }
            
            if let color = secondColor?.cgColor {
                colors.append(color)
            }
            
            if let color = secondColor?.cgColor {
                colors.append(color)
            }
        }
        gradientLayer.colors = colors // 设置渐变层的颜色数组
        gradientLayer.startPoint = startPoint // 设置渐变层的起始点
        gradientLayer.endPoint = endPoint // 设置渐变层的结束点
        gradientLayer.locations = locations // 设置渐变层的颜色位置
    }

//    override var intrinsicContentSize: CGSize {
//        return self.bounds.size
//    }

}



@available(iOS 17.0, *)
#Preview{
    let view  = KTVColorsGradientView(frame: CGRect(x: 0, y: 0, width: 300, height: 44))
    view.setColors([
        UIColor(named: "#FFB2D933")!,
        UIColor(named: "#FCD5FF")!
    ])
    return view
}

