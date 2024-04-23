//
//  KTVHEqualSpacingContainer.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/4/23.
//

import UIKit


class KTVHEqualSpacingContainer: UIView {
    private lazy var stackView: UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.distribution = .equalSpacing
        s.alignment = .center
        s.spacing = 8
        return s
    }()
    
    var spaceing: CGFloat = 8 {
        didSet {
            self.stackView.spacing = spaceing
        }
    }
    
    var itemSize: CGSize = CGSize(width: 28, height: 28) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func appendView(_ view: UIView) {
        self.stackView.addArrangedSubview(view)
    }
   
    override var intrinsicContentSize: CGSize {
        let count = stackView.subviews.count
        return CGSize(width: CGFloat(count) * itemSize.width + CGFloat(count - 1) * spaceing, height: itemSize.height)
    }
    
}



#Preview("KTVHEqualSpacingContainer", traits: .portrait) {
    let view = KTVHEqualSpacingContainer()
    view.backgroundColor = .blue
    for _ in 0 ..< 8 {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height:28))
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .red
        view.appendView(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 28),
            imageView.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    return view
}
