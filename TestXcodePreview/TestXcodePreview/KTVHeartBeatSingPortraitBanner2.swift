//
//  KTVHeartBeatSingPortraitBanner.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/10/23.
//

import UIKit

class KTVHeartBeatSingPortraitBanner2: UIView {

    private var timer: Timer?
    private var imageViews: [UIImageView] = []
    private var startIndex = 0
    var icons: [String] = [] {
        didSet {
            setup()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
   
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePortrait), userInfo: nil, repeats: true)
        guard let t = timer else { fatalError() }
        RunLoop.current.add(t, forMode: .common)
    }
    
    private func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func invalidateTimer() {
        stopTimer()
    }
    
    
    @objc private  func updatePortrait() {
        
        let first = self.imageViews.removeFirst()
        first.alpha = 0
        //first.image = nil
        UIView.animate(withDuration: 0.35) {
            self.container.appendView(first)
            first.superview?.bringSubviewToFront(first)
            first.image = UIImage(named: self.icons[self.startIndex % self.icons.count])
            self.imageViews.append(first)
        } completion: { _ in
            
            first.alpha = 1
        }

        self.startIndex = self.startIndex + 1
     
    }
    
    lazy var container: KTVHEqualSpacingContainer = {
        let view = KTVHEqualSpacingContainer()
        
        view.spaceing = -6
        return view
    }()
    
    func setup() {
        imageViews.removeAll()
        container.removeFromSuperview()
        
        for i in 0 ..< min(3,self.icons.count) {
            let imageView = UIImageView()
            imageView.contentMode = .scaleToFill
            imageView.image = UIImage(named: self.icons[i])
            imageViews.append(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 28),
                imageView.heightAnchor.constraint(equalToConstant: 28)
            ])
        }
        
        imageViews.forEach { imageView in
            container.appendView(imageView)
        }
        self.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        if self.icons.count > 3 {
            self.startIndex = min(3,self.icons.count)
            startTimer()
        }
    }
    
    
    override var intrinsicContentSize: CGSize {
        container.intrinsicContentSize
    }

}


#Preview("PortraitBanner", traits: .portrait) {
    let view = KTVHeartBeatSingPortraitBanner2()
//    view.icons = ["avatar1", "avatar2", "avatar3","child", "cup", "member", "like_test"]
    //view.icons = ["avatar1", "avatar2", "avatar3"]
    view.icons = ["avatar1", "avatar2", "avatar3","child"]
    //view.backgroundColor = .red
    return view
}
