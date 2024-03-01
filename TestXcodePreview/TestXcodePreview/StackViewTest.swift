//
//  StackViewTest.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/1/25.
//

import UIKit

class StackViewTest: UIView {

    
    
    private lazy  var statck: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 8
        return stack
    }()
    
     lazy var imageView1: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.backgroundColor = .red
        return imageView
    }()
    
    
    lazy var imageView2: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.backgroundColor = .green
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupView() {
        self.statck.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.statck)
        self.statck.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.statck.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        imageView1.backgroundColor = .red
        imageView1.widthAnchor.constraint(equalToConstant: 50).isActive  = true
        imageView1.heightAnchor.constraint(equalToConstant: 50).isActive  = true
        
        self.statck.addArrangedSubview(imageView1)
        
    
        imageView2.widthAnchor.constraint(equalToConstant: 50).isActive  = true
        imageView2.heightAnchor.constraint(equalToConstant: 50).isActive  = true
        imageView2.backgroundColor = .green
        self.statck.addArrangedSubview(imageView2)
    }
    
    override var intrinsicContentSize: CGSize {
        return self.bounds.size
    }
    
}



#Preview {
    let view  = StackViewTest(frame: CGRect(x: 0, y: 0, width: 60, height: 110))
    //let view  = StackViewTest()
    view.backgroundColor = .blue
    return view
}


#Preview {
    let view  = StackViewTest(frame: CGRect(x: 0, y: 0, width: 60, height: 110))
    view.imageView1.isHidden = true
    view.backgroundColor = .blue
    return view
}
