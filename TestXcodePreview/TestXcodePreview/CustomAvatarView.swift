//
//  CustomAvatarView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/4/8.
//

import UIKit

class CustomAvatarView: UIImageView {

    private var shapeLayer: CAShapeLayer?

       init() {
           super.init(frame: .zero)
           self.shapeLayer = CAShapeLayer()
           layer.mask = self.shapeLayer
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       override func layoutSubviews() {
           super.layoutSubviews()
           updatePath()
       }

       private func createBezierPath() -> UIBezierPath {
           let path = UIBezierPath()
           let scaleFactor = min(bounds.width, bounds.height) / 74.0
           path.move(to: CGPoint(x: 74 * scaleFactor, y: 37 * scaleFactor))
           path.addCurve(to: CGPoint(x: 37 * scaleFactor, y: 74 * scaleFactor),
                         controlPoint1: CGPoint(x: 74 * scaleFactor, y: 61.0551 * scaleFactor),
                         controlPoint2: CGPoint(x: 61.0551 * scaleFactor, y: 74 * scaleFactor))
           path.addCurve(to: CGPoint(x: 0, y: 37 * scaleFactor),
                         controlPoint1: CGPoint(x: 12.9449 * scaleFactor, y: 74 * scaleFactor),
                         controlPoint2: CGPoint(x: 0, y: 61.0551 * scaleFactor))
           path.addCurve(to: CGPoint(x: 37 * scaleFactor, y: 0),
                         controlPoint1: CGPoint(x: 0, y: 12.9449 * scaleFactor),
                         controlPoint2: CGPoint(x: 12.9449 * scaleFactor, y: 0))
           path.addCurve(to: CGPoint(x: 74 * scaleFactor, y: 37 * scaleFactor),
                         controlPoint1: CGPoint(x: 61.0551 * scaleFactor, y: 0),
                         controlPoint2: CGPoint(x: 74 * scaleFactor, y: 12.9449 * scaleFactor))
           path.close()
           return path
       }

       private func updatePath() {
           let path = createBezierPath()
           shapeLayer?.path = path.cgPath
       }

}
