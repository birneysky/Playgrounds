//
//  MyShapeView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/4/8.
//

import UIKit

class MyShapeView: UIView {

    // 形状缩放比例
      private var scale: CGFloat = 1.0
      
      // 初始化方法
      override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
      }
      
      required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      }
      
      // 绘制形状
      override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        
        // 将矩形按比例缩放
          let scaledRect = CGRect(x: rect.origin.x , y: rect.origin.y, width: rect.size.width * scale, height: rect.size.height * scale)
        
        // 移动到起点
        context.move(to: CGPoint(x: 3.98079 * scale, y: 7.03443 * scale))
        
        // 绘制第一条贝塞尔曲线
        context.addCurve(to: CGPoint(x: 11.9223 * scale, y: 0 * scale),
                         control1: CGPoint(x: 4.46898 * scale, y: 3.01916 * scale),
                         control2: CGPoint(x: 7.87746 * scale, y: 0 * scale))
        
        // 绘制第二条贝塞尔曲线
        context.addCurve(to: CGPoint(x: 177 * scale, y: 8 * scale),
                         control1: CGPoint(x: 173.418 * scale, y: 0 * scale),
                         control2: CGPoint(x: 177 * scale, y: 3.58172 * scale))
        
        // 绘制第三条贝塞尔曲线
        context.addCurve(to: CGPoint(x: 169 * scale, y: 48 * scale),
                         control1: CGPoint(x: 177 * scale, y: 44.4183 * scale),
                         control2: CGPoint(x: 173.418 * scale, y: 48 * scale))
        
        // 绘制第四条贝塞尔曲线
        context.addCurve(to: CGPoint(x: 0.0900758 * scale, y: 39.0344 * scale),
                         control1: CGPoint(x: 3.23039 * scale, y: 48 * scale),
                         control2: CGPoint(x: -0.489408 * scale, y: 43.8005 * scale))
        
        // 绘制回到起点的线
        context.addLine(to: CGPoint(x: 3.98079 * scale, y: 7.03443 * scale))
        
        // 填充颜色
        context.setFillColor(UIColor.blue.cgColor)
        context.fillPath()
      }
    
    // 更新缩放比例
    func updateScale(to newScale: CGFloat) {
      scale = newScale
      setNeedsDisplay()
    }
    
    override var intrinsicContentSize: CGSize {
        return self.bounds.size
    }

}


#Preview("MCInfiniteScrollView", traits: .portrait) {
    let shapeView = MyShapeView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
    return shapeView
        
}


