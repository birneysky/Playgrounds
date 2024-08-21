//
//  KTVWebContainerLoadingView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/8/15.
//

import UIKit

class KTVWebContainerLoadingView: UIView {

    @IBOutlet weak var musicIconImageView: UIImageView!
    @IBOutlet weak var bottomCircle: UIImageView!
    @IBOutlet weak var topCircle: UIImageView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        startBounceAnimation(withLayer: topCircle.layer, postionOffset: -60)
        startBounceAnimation(withLayer: bottomCircle.layer, postionOffset: 60)
    }
    func startBounceAnimation(withLayer layer: CALayer, postionOffset: CGFloat) {
         // 创建 CABasicAnimation 对象
         let animation = CABasicAnimation(keyPath: "position.y")
         
         // 设置动画的起点和终点
         animation.fromValue = layer.position.y
         animation.toValue = layer.position.y + postionOffset
         
         // 动画时间
         animation.duration = 2.0
         
         // 自动反转动画
         animation.autoreverses = true
         
         // 无限重复动画
         animation.repeatCount = Float.infinity
         
         // 添加动画到图层
         layer.add(animation, forKey: "bounce")
     }

}


#Preview {
    let view = KTVWebContainerLoadingView.view()
    view.backgroundColor = .red
    return view
}
