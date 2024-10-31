//
//  KTVHeartBeatSingPortraitBanner3.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/11/1.
//

import UIKit

class KTVHeartBeatSingPortraitBanner3: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private var timer: Timer?
    private var imageViews: [UIImageView] = []
    private var startIndex = 0
    private var container = UIView()
    var spacing: CGFloat = -8.0 // 控制头像之间的重叠量
    @objc var avatars: [String] = []  {
           didSet {
               setupViews()
           }
    }
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(updatePortrait), userInfo: nil, repeats: true)
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
    
    var aImageView: UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .green
        imageView.layer.cornerRadius = 18
        imageView.layer.masksToBounds = true
        return imageView
    }
    
    func setupViews() {
        imageViews.removeAll()
        container.removeFromSuperview()
       
        let count = min(3,self.avatars.count)
        for i in 0 ..<  count {
            let imageView = aImageView
            imageView.image = UIImage(named: self.avatars[i])
            imageViews.append(imageView)
            self.container.addSubview(imageView)
            let x: CGFloat  = CGFloat(i * 32) + CGFloat(i) * spacing
            imageView.frame = CGRect(x: x , y: 0, width: 32, height: 32)
        }
        
        self.addSubview(self.container)
        
        let lastView = aImageView;
        lastView.image = UIImage(named: "cup")
        imageViews.append(lastView)
        lastView.frame = CGRect(x: contentSize.width , y: 0, width: 32, height: 32)
        self.container.addSubview(lastView)
        
        self.container.clipsToBounds = true
        self.container.backgroundColor = .black
        if self.avatars.count > 3 {
            self.startIndex = min(3,self.avatars.count)
            startTimer()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.container.frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
        //self.container.center  = self.center
    }
    
    
    @objc private  func updatePortrait() {
        
        let firstView = self.imageViews.removeFirst()
        //firstView.removeFromSuperview()
        let lastView = self.imageViews.last
        lastView?.image =  UIImage(named: self.avatars[self.startIndex % self.avatars.count])
        lastView?.frame = CGRect(x: 80 , y: 0, width: 32, height: 32)
        UIView.animate(withDuration: 0.35) {
            firstView.frame = CGRect(x: -32 , y: 0, width: 32, height: 32)
            firstView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            firstView.alpha = 0
            for i in 0 ..<  self.imageViews.count {
                let x: CGFloat  = CGFloat(i * 32) + CGFloat(i) * self.spacing
                self.imageViews[i].frame = CGRect(x: x , y: 0, width: 32, height: 32)
            }

        } completion: { _ in
                firstView.image = nil
                firstView.alpha = 1
                firstView.transform = CGAffineTransform.identity
                self.imageViews.append(firstView)
            
                firstView.frame = CGRect(x: 100 , y: 0, width: 32, height: 32)
                self.container.bringSubviewToFront(firstView)
            
        }

        self.startIndex = self.startIndex + 1
     
    }
    
    
    var contentSize: CGSize {
        
        let itemHeight:CGFloat = 32
        
        // 计算 contentSize 的宽度
        let totalWidth = 3 * 32 + CGFloat(3-1) * spacing
        
        return CGSizeMake(totalWidth, itemHeight)
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize;
    }
}


#Preview("PortraitBanner", traits: .portrait) {
    let view = KTVHeartBeatSingPortraitBanner3()
    view.avatars = ["avatar1", "avatar2", "avatar3","child", "cup", "member", "like_test"]
    view.backgroundColor = .red
    view.clipsToBounds = false
    return view
}
