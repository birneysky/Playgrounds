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
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }()
    
    private lazy var label: UILabel = {
       UILabel()
    }()
    
    var text: String? {
        didSet {
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(gradientLayer)
        self.addSubview(label)
        gradientLayer.mask = self.label.layer
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.bounds = self.label.bounds
        gradientLayer.frame = self.label.frame
    }
    
    override var intrinsicContentSize: CGSize {
        self.label.bounds.size
    }

}

#Preview {
    let view  = GradientLabel()
    //let view  = StackViewTest()
    view.text = "Hello world"
    view.font = UIFont.systemFont(ofSize: 50)
    return view
}

