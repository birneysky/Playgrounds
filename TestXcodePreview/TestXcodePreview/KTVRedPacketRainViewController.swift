//
//  KTVRedPacketRainViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/12/19.
//

import UIKit



class RedPacketView: UIView {
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        self.backgroundColor = .red
        self.layer.cornerRadius = 5
        
        // 添加一个图标到红包视图中
        let imageView = UIImageView(image: UIImage(named: "ktv_spring_red_packet_icon"))
        imageView.tintColor = .white
        imageView.frame = self.bounds
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class KTVRedPacketRainViewController: UIViewController {
        let redPacketCount = 12
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = .blue
            self.view.clipsToBounds = true
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for _ in 0..<redPacketCount {
            let redPacket = RedPacketView()
            print("------------------- \(self.view.bounds.width), \(self.view.bounds.height)")
            let startX = CGFloat.random(in: 0...self.view.bounds.width)
            let startY = CGFloat.random(in: -self.view.bounds.height...0)
            redPacket.frame.origin = CGPoint(x: startX, y: startY)
            self.view.addSubview(redPacket)
            
            animateRedPacket(redPacket)
        }
    }
        
        func animateRedPacket(_ redPacket: RedPacketView) {
            
            let endY = self.view.bounds.height + redPacket.bounds.height
            let randomx = CGFloat.random(in: 0...self.view.bounds.width)
            let duration = CGFloat.random(in: 4...6)
            
            // 掉落动画
            let fallAnimation = CABasicAnimation(keyPath: "position")
            fallAnimation.fromValue = redPacket.layer.position
            fallAnimation.toValue = CGPoint(x: randomx, y: endY)
            fallAnimation.duration = CFTimeInterval(duration)
            fallAnimation.repeatCount = .greatestFiniteMagnitude
            fallAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
            redPacket.layer.add(fallAnimation, forKey: "fallAnimation")
            // 旋转动画
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.toValue = NSNumber(value: Double.pi * 2)
            rotationAnimation.duration = TimeInterval(CGFloat.random(in: 1...2))
            rotationAnimation.isCumulative = true
            rotationAnimation.repeatCount = .greatestFiniteMagnitude
            redPacket.layer.add(rotationAnimation, forKey: "rotationAnimation")
        }

}


@available(iOS 17.0, *)
#Preview{
    let parentController = UIViewController()
    parentController.view.backgroundColor = .black
    let controller = KTVRedPacketRainViewController()
    parentController.addChild(controller)
    parentController.view.addSubview(controller.view)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        controller.view.centerXAnchor.constraint(equalTo: parentController.view.centerXAnchor),
        controller.view.centerYAnchor.constraint(equalTo: parentController.view.centerYAnchor),
        controller.view.widthAnchor.constraint(equalToConstant: 291),
        controller.view.heightAnchor.constraint(equalToConstant: 160),
    ])
    return parentController;
}
