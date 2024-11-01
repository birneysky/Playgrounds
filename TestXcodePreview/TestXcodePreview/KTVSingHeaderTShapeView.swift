//
//  KTVSingHeaderTShapeView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/4/8.
//

import UIKit

class KTVSingHeaderTShapeView: UIView {

    // 形状缩放比例
      private var scale: CGFloat = 1.0
     private var shapeLayer = CAShapeLayer()
      // 初始化方法
      override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
          layer.mask = shapeLayer
      }
      
      required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      }

      
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePath()
    }
    
    private func updatePath() {
        let path = createBezierPath()
        shapeLayer.path = path.cgPath
    }
    
    
    func createBezierPath() -> UIBezierPath {
        let scaleFactor = min(bounds.width, bounds.height) / 48.0
        let path = UIBezierPath()
        path.move(to: CGPoint(x: scaleFactor * 3.98079, y: scaleFactor * 7.03443))
        path.addCurve(to: CGPoint(x: scaleFactor *  11.9223, y: scaleFactor * 0), controlPoint1: CGPoint(x: scaleFactor *  4.46898, y: scaleFactor *  3.01916), controlPoint2: CGPoint(x: scaleFactor *  7.87746, y: 0))
        path.addLine(to: CGPoint(x: scaleFactor * 169, y: 0))
        path.addCurve(to: CGPoint(x: scaleFactor * 177, y:  scaleFactor * 8), controlPoint1: CGPoint(x: scaleFactor * 173.418, y: 0), controlPoint2: CGPoint(x: scaleFactor * 177, y: scaleFactor * 3.58172))
        path.addLine(to: CGPoint(x: scaleFactor * 177, y: scaleFactor * 40))
        path.addCurve(to: CGPoint(x: scaleFactor * 169, y: scaleFactor * 48), controlPoint1: CGPoint(x: scaleFactor * 177, y: scaleFactor * 44.4183), controlPoint2: CGPoint(x: scaleFactor * 173.418, y: scaleFactor * 48))
        path.addLine(to: CGPoint(x: scaleFactor * 8.03158, y: scaleFactor * 48))
        path.addCurve(to: CGPoint(x: scaleFactor * 0.0900758, y: scaleFactor * 39.0344), controlPoint1: CGPoint(x: scaleFactor * 3.23039, y: scaleFactor * 48), controlPoint2: CGPoint(x: scaleFactor * -0.489408, y: scaleFactor * 43.8005))
        path.addLine(to: CGPoint(x: scaleFactor * 3.98079, y: scaleFactor * 7.03443))
        path.close()
        return path
    }
    
    override var intrinsicContentSize: CGSize {
        return self.bounds.size
    }

}


@available(iOS 17.0, *)
#Preview("MCInfiniteScrollView", traits: .portrait) {
    let shapeView = KTVSingHeaderTShapeView(frame: CGRect(x: 0, y: 0, width: 193, height: 54))
    var frame = shapeView.bounds
    frame.origin.x = frame.origin.x - 8
    frame.origin.y = frame.origin.y - 8
    frame.size.width = frame.size.width + 16
    frame.size.height = frame.size.height + 16
    let scrollView = KTVSingHeaderBannerScrollView(frame: frame)
    scrollView.items = [
        KTVSingBannerItem(backgroundImageName: "ktv_sing_with_past_self", iconImageName: "ktv_past_self_icon", titleText: "0001", subTitleLabel: "0001sub"),
        KTVSingBannerItem(backgroundImageName: "ktv_annual_celebration_report", iconImageName: "ktv_past_self_icon", titleText: "0002", subTitleLabel: "0002sub"),
        KTVSingBannerItem(backgroundImageName: "ktv_annual_celebration_report", iconImageName: "ktv_past_self_icon", titleText: "0003", subTitleLabel: "0003sub"),
    ]
    shapeView.addSubview(scrollView)
    shapeView.backgroundColor = .red
    return shapeView
        
}


