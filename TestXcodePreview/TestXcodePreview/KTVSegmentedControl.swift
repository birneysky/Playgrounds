//
//  KTVSegmentedControl.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/3/18.
//

import UIKit


struct KTVSegmentItem {
    var title: String = ""
    var size: CGSize =  .init(width: 44, height: 44)
}

class KTVSegmentedControl: UIControl {
    private let stackView = UIStackView()
    private var buttons = [UIButton]()
    private var selector: UIView!
    
    var items: [KTVSegmentItem] = [] {
        didSet {
            configureSegments()
        }
    }
    
    var titles: [String] = [] {
        didSet {
            configureSegments()
        }
    }
    
    var segmentSpacing: CGFloat = 10 {
        didSet {
            stackView.spacing = segmentSpacing
        }
    }
    
    
    var selectedIndex = 0 {
        // Trigger UI update when selectedIndex is changed
        didSet {
           // Update UI based on new index
            updateSegmentedControlSegment(with: selectedIndex)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureStackView()
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 8 // Here is where you set your custom spacing
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func configureSegments() {
        for item in items {
            let button = UIButton(type: .custom)
            button.addTarget(self, action: #selector(segmentTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
            
            // Set the color for both normal and selected states
            button.setTitleColor(UIColor(named: "#CCCCCC"), for: .normal) // Normal State ColorFF3348
            button.setTitleColor(.white, for: .selected) // Selected State Color
            button.setTitle(item.title, for: .normal)
            button.backgroundColor = .clear // Background Color
            button.layer.cornerRadius = item.size.height / 2
            button.layer.masksToBounds = true
            //button.set
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: item.size.width),
                button.heightAnchor.constraint(equalToConstant: item.size.height)
            ])
        }
    }
    
    @objc private func segmentTapped(_ sender: UIButton) {
        guard let index = buttons.firstIndex(of: sender) else { return }
        selectedIndex = index
        // Update selector and button states
        updateSegmentedControlSegment(with: index)
    }
    
    private func updateSegmentedControlSegment(with index: Int) {
        for (buttonIndex, button) in buttons.enumerated() {
            //UIView.animate(withDuration: 0.3) {
                button.isSelected = index == buttonIndex
                if index == buttonIndex {
                    button.backgroundColor = UIColor(named: "#ff3348")
                } else {
                    button.backgroundColor = UIColor(named: "#ff3348")?.withAlphaComponent(0.005)
                }
                self.layoutIfNeeded()
            //}
        }
        // You can additionally add selector view or update UI in other ways
    }

    override var intrinsicContentSize: CGSize {
        return self.bounds.size
    }
}


@available(iOS 17.0, *)
#Preview{
    let view  = KTVSegmentedControl(frame: CGRect(x: 0, y: 0, width: 300, height: 44))
    view.items = [
        KTVSegmentItem(title: "周榜", size: CGSizeMake(88, 24)),
        KTVSegmentItem(title: "月榜", size: CGSizeMake(88, 24)),
        KTVSegmentItem(title: "总榜", size: CGSizeMake(88, 24)),
    ]
    view.selectedIndex = 0
    view.segmentSpacing = 8
    
    return view
}
