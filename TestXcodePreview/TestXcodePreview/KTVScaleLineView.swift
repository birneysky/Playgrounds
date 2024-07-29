//
//  KTVScaleLineView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/7/23.
//

import UIKit

enum KTVFineTuningLineViewStyle {
    case begin
    case end
}

class KTVScaleLineView: UIView {
    // 基准线的位置
    var baselineY: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    var duration: TimeInterval {
        return endTime - startTime
    }
    var startTime: TimeInterval
    var endTime: TimeInterval
    var currTime: TimeInterval = 0
    private var style: KTVFineTuningLineViewStyle
    // 初始化方法
    init(frame: CGRect, style: KTVFineTuningLineViewStyle, startTime: TimeInterval, endTime: TimeInterval) {
        self.style = style
        self.startTime =  startTime
        self.endTime = endTime
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("unsupport nib")
    }
    
//    init(style: KTVFineTuningLineViewStyle) {
//        self.style = style
//        
//    }


    private lazy var tuningLine:KTVFineTuningLineView = {
        let view  = KTVFineTuningLineView.view()
        view.style = self.style
        view.backgroundColor = .yellow.withAlphaComponent(0.2)
        view.increase = {[weak self] in
            guard let self = self else { return }
            self.increaseTime()
        }
        
        view.decrease = {[weak self] in
            guard let self = self else { return }
            self.decreaseTime()
        }
        return view
    }()
    
    
    private lazy var firstLyricsLabel = {
        let label = UILabel()
        label.textColor = style == .begin ? rgba("##FFFFFF4D") :rgba("#FF3348FF")
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    
    private lazy var lastLyricsLabel = {
        let label = UILabel()
        label.textColor = style == .begin ? rgba("#FF3348FF") :rgba("##FFFFFF4D")
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()

    func increaseTime() {
        let offset = 10.0 / secondPerPoint
        if tuningLine.style == .begin {
            self.baselineY -= offset
        } else {
            self.baselineY += offset
        }
        currTime += 10
        if self.baselineY <= topOffset {
            self.baselineY = topOffset
        }
        
        if self.baselineY >= topOffset + scaleLineHeight {
            self.baselineY = topOffset + scaleLineHeight
        }
        
        tuningLine.center = CGPoint(x: bounds.midX, y: self.baselineY)
        
        if currTime > duration {
            currTime = duration
        }
        print("+++ offset\(offset) time\(offSetTime),curtime\(currTime) duration\(duration)")
        updatetTimeLabel()
    }
    
    func decreaseTime() {
        let offset = 10.0 / secondPerPoint
        if tuningLine.style == .begin {
            self.baselineY += offset
        } else {
            self.baselineY -= offset
            
        }
        currTime -= 10
        
        if self.baselineY <= topOffset {
            self.baselineY = topOffset
        }
        
        if self.baselineY >= topOffset + scaleLineHeight {
            self.baselineY = topOffset + scaleLineHeight
        }
        if currTime < 0 {
            currTime = 0
        }
        tuningLine.center = CGPoint(x: bounds.midX, y: self.baselineY)
        print("+++ offset\(offset) time\(offSetTime),curtime\(currTime) duration\(duration)")
        updatetTimeLabel()
    }
    

    let lineHeight: CGFloat = 5 // 每条线之间的距离
    let topOffset: CGFloat = 31
    var centerY: CGFloat = 0
    var lineNum: Int {
        var num = 3000
        if duration > 0 , duration <= 3000 {
            num = 3
        } else if duration > 3000, duration <= 30000 {
            num = 13
        } else {
            num = 21
        }
        return num
    }
    
    func updatetTimeLabel() {
        switch style {
        case .begin:
            tuningLine.setTime(endTime - currTime)
        case .end:
            tuningLine.setTime(startTime + currTime)
        }
    }
    
    var scaleLineHeight: CGFloat {
        let lineTotalHeight: CGFloat = CGFloat(lineNum) * CGFloat(2) + CGFloat(lineNum - 1) * CGFloat(lineHeight)
        return lineTotalHeight + 2
    }
    
    var secondPerPoint: TimeInterval {
        return duration / scaleLineHeight;
    }
    
    var offSetTime: TimeInterval {
        if tuningLine.style == .end {
            return (baselineY - topOffset) * secondPerPoint
        } else {
            print("tttttz \(scaleLineHeight-(baselineY - topOffset))")
            if scaleLineHeight-(baselineY - topOffset) <= 0.01 {
                return 0
            }
            return (scaleLineHeight-(baselineY - topOffset)) * secondPerPoint
        }
        
    }
    
    private func setup() {
        // 设置初始基准线位置为视图的中心
        baselineY = bounds.midY
        self.addSubview(tuningLine)
        // 添加拖动手势
        let slidingPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSlidingPan(_:)))
        tuningLine.addGestureRecognizer(slidingPanGesture)
        
        
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
        
        
        firstLyricsLabel.text = "尽管讲出不快吧"
        addSubview(firstLyricsLabel)
        
        firstLyricsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstLyricsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            firstLyricsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        ])
        
        lastLyricsLabel.text = "仍然紧守于身边"
        addSubview(lastLyricsLabel)
        lastLyricsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lastLyricsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            lastLyricsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        invalidateIntrinsicContentSize()
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let selfHeight = scaleLineHeight + CGFloat(31 * 2)
        var frame = self.frame
        frame.size.height = Double(selfHeight)
        self.bounds = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: selfHeight)
        baselineY = self.bounds.maxY / 2
        centerY = baselineY
        tuningLine.center = CGPoint(x: self.bounds.maxX / 2, y: baselineY)
        print("base y\(baselineY) bounds:\(self.bounds), center:\(self.center) time:\(offSetTime)")
        currTime = offSetTime
        updatetTimeLabel()
    }

        @objc private func handleSlidingPan(_ gesture: UIPanGestureRecognizer) {
            let translation = gesture.translation(in: self)
            gesture.setTranslation(.zero, in: self)
            //baselineY += translation.y
            // 限制基准线在视图范围内
            var newY = baselineY + translation.y
            newY = min(max(newY, 0), bounds.height)
            if newY + topOffset <= bounds.maxY &&
                newY - topOffset >= 0 {
                
                
                if abs(newY + topOffset - bounds.maxY) <= 0.5 {
                    newY = bounds.maxY - topOffset;
                }
                
                if abs(newY  - topOffset) <= 0.5 {
                    newY = topOffset;
                    print("---------\(newY)")
                }
                tuningLine.center = CGPoint(x: bounds.midX, y: newY)
                baselineY = newY
                
                print("-------- hhh \(baselineY - topOffset) scaleLineHeight:\(scaleLineHeight), time:\(offSetTime)")
                currTime = offSetTime
                updatetTimeLabel()
            }
            
        }

        override func draw(_ rect: CGRect) {
            guard let context = UIGraphicsGetCurrentContext() else { return }
            let numberOfLines = lineNum
            let width: [CGFloat] = [16, 50, 90, 50, 16]
            var yPosition: CGFloat = topOffset + 2
            for i in 0 ..< numberOfLines {
                context.setLineWidth(2.0)
                if yPosition < baselineY {
                    if self.style == .begin {
                        context.setStrokeColor(UIColor.gray.cgColor)
                    } else {
                        context.setStrokeColor(UIColor.red.cgColor)
                    }
                } else {
                    if self.style == .begin {
                        context.setStrokeColor(UIColor.red.cgColor)
                    } else {
                        context.setStrokeColor(UIColor.gray.cgColor)
                    }
                    
                }
                let lineW = width[i % 5]
                let x =  (bounds.width - lineW) / 2
                
                context.move(to: CGPoint(x: x, y: yPosition))
                context.addLine(to: CGPoint(x: x + lineW, y: yPosition))
                context.strokePath()
                yPosition +=  lineHeight + 2
            }
        }
    
    override var intrinsicContentSize: CGSize {
        let selfHeight = scaleLineHeight + CGFloat(31 * 2)
        return CGSize(width: self.bounds.size.width, height: selfHeight)
        
    }
}


#Preview("KTVScaleLineViewBegin", traits: .portrait) {
    let view = KTVScaleLineView(frame: CGRect(x: 0, y: 0, width: 397, height: 0), style: .begin, startTime: 10000, endTime: 15000)
    return view
}


#Preview("KTVScaleLineViewEnd", traits: .portrait) {
    let view = KTVScaleLineView(frame: CGRect(x: 0, y: 0, width: 397, height: 0), style: .end, startTime: 20000, endTime: 35000)
    return view
}
