//
//  KTVScaleLineView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/7/23.
//

import UIKit

class KTVScaleLineView: UIView {
    // 基准线的位置
        var baselineY: CGFloat = 0 {
            didSet {
                setNeedsDisplay()
            }
        }

        var duration: TimeInterval = 3
        // 初始化方法
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }
    
    
        private lazy var tuningLine:KTVFineTuningLineView = {
            let view  = KTVFineTuningLineView.view()
            view.style = .begin
            view.backgroundColor = .yellow.withAlphaComponent(0.2)
            return view
        }()
    


        let lineHeight: CGFloat = 5 // 每条线之间的距离
        let topOffset: CGFloat = 31
        private func setup() {
            // 设置初始基准线位置为视图的中心
            baselineY = bounds.midY
            self.addSubview(tuningLine)
            // 添加拖动手势
            let slidingPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSlidingPan(_:)))
            tuningLine.addGestureRecognizer(slidingPanGesture)
            
            var lineNum = 3
            if duration > 0 , duration <= 3 {
                lineNum = 3
            } else if duration > 3, duration <= 30 {
                lineNum = 13
            } else {
                lineNum = 21
            }
            
            let lineTotalHeight:CGFloat =  CGFloat(lineNum - 1) * CGFloat(lineHeight) + CGFloat(lineNum) * CGFloat(2)
            let selfHeight = lineTotalHeight + CGFloat(31 * 2) + 10
            var frame = self.frame
            frame.size.height = Double(selfHeight)
            self.bounds = frame
            
        
            
            tuningLine.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tuningLine.heightAnchor.constraint(equalToConstant: 62),
                tuningLine.widthAnchor.constraint(equalTo: self.widthAnchor)
            ])
            invalidateIntrinsicContentSize()
        }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        var lineNum = 3
        if duration > 0 , duration <= 3 {
            lineNum = 3
        } else if duration > 3, duration <= 30 {
            lineNum = 13
        } else {
            lineNum = 21
        }
        
        let lineTotalHeight:CGFloat = CGFloat(lineNum) * CGFloat(2) + CGFloat(lineNum - 1) * CGFloat(lineHeight)
        let selfHeight = lineTotalHeight + CGFloat(31 * 2) + 4
        var frame = self.frame
        frame.size.height = Double(selfHeight)
        self.bounds = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: selfHeight)
        baselineY = self.bounds.maxY / 2
        tuningLine.center = CGPoint(x: self.bounds.maxX / 2, y: baselineY)
        NSLog("base y\(baselineY) bounds:\(self.bounds), center:\(self.center)")
    }

        @objc private func handleSlidingPan(_ gesture: UIPanGestureRecognizer) {
            let translation = gesture.translation(in: self)
            gesture.setTranslation(.zero, in: self)
            //baselineY += translation.y
            // 限制基准线在视图范围内
            var newY = baselineY + translation.y
            newY = min(max(newY, 0), bounds.height)
            if newY + tuningLine.bounds.size.height  / 2 <= bounds.maxY &&
                newY - tuningLine.bounds.height / 2 >= 0 {
                tuningLine.center = CGPoint(x: bounds.midX, y: newY)
                baselineY = newY
                print("---------\(newY)")
            }
            
        }

        override func draw(_ rect: CGRect) {
            guard let context = UIGraphicsGetCurrentContext() else { return }

            
            var lineNum = 3
            if duration > 0 , duration <= 3 {
                lineNum = 3
            } else if duration > 3, duration <= 30 {
                lineNum = 13
            } else {
                lineNum = 21
            }
            let numberOfLines = lineNum//Int((bounds.height - topOffset * 2) / lineHeight)
            let width: [CGFloat] = [16, 50, 90, 50, 16]
            var yPosition: CGFloat = topOffset + 2
            for i in 0 ..< numberOfLines {
                context.setLineWidth(2.0)
                if yPosition < baselineY {
                    context.setStrokeColor(UIColor.gray.cgColor)
                } else {
                    context.setStrokeColor(UIColor.red.cgColor)
                }
                let lineW = width[i % 5]
                let x =  (bounds.width - lineW) / 2
                
                context.move(to: CGPoint(x: x, y: yPosition))
                context.addLine(to: CGPoint(x: x + lineW, y: yPosition))
                context.strokePath()
                yPosition +=  lineHeight + 2
            }

//            // 绘制基准线
//            context.setStrokeColor(UIColor.black.cgColor)
//            context.setLineWidth(2.0)
//            context.move(to: CGPoint(x: 0, y: baselineY))
//            context.addLine(to: CGPoint(x: bounds.width, y: baselineY))
//            context.strokePath()
        }
    
    override var intrinsicContentSize: CGSize {
        var lineNum = 3
        if duration > 0 , duration <= 3 {
            lineNum = 3
        } else if duration > 3, duration <= 30 {
            lineNum = 13
        } else {
            lineNum = 21
        }
        
        let lineTotalHeight:CGFloat = CGFloat(lineNum) * CGFloat(2) + CGFloat(lineNum - 1) * CGFloat(lineHeight)
        let selfHeight = lineTotalHeight + CGFloat(31 * 2) + 4
        var frame = self.frame
        frame.size.height = Double(selfHeight)
        self.bounds = frame
        return self.bounds.size
        
    }
}


#Preview("KTVLRRedPacketObtainRewardsView", traits: .portrait) {
    let view = KTVScaleLineView(frame: CGRect(x: 0, y: 0, width: 397, height: 84))
    return view
}
