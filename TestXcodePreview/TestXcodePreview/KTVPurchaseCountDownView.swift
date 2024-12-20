//
//  KTVPurchaseCountDownView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/12/18.
//

import UIKit

class KTVPurchaseCountDownView: UIView {

    private var timerLabel: UILabel!
    private var deadlineTime: TimeInterval
    private var elapsedTime: TimeInterval = 0
    private var displayLink: CADisplayLink?
    
    ///截止时间 单位 ms
    @objc init(startTime: TimeInterval) {
        self.deadlineTime = startTime / 1000.0
        super.init(frame: .zero)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("unsupport xib")
    }
    
    private func setup() {
        let currentTime = CACurrentMediaTime()
        let totalElapsedTime = elapsedTime + (deadlineTime - currentTime)

        let minutes = Int(totalElapsedTime) / 60
        let seconds = Int(totalElapsedTime) % 60
        let milliseconds = Int((totalElapsedTime - floor(totalElapsedTime)) * 1000)
        
        timerLabel = UILabel()
        timerLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 12, weight: .regular) // 使用等宽字体
        timerLabel.textAlignment = .center
        timerLabel.textColor = rgba("#923B3DFF")
        //timerLabel.text = "00:10.00折扣结束" // 初始时间
        timerLabel.text = String(format: "%02d:%02d.%02d折扣结束", minutes, seconds, getFirstTwoDigits(of: milliseconds))
        addSubview(timerLabel)
        self.backgroundColor = rgba("#FEBCC2FF");
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.timerLabel.frame = self.bounds
    }
    
    @objc func toggleTimer() {
        if displayLink == nil {
            // 开始计时
            //startTime = CACurrentMediaTime() + 10
            displayLink = CADisplayLink(target: self, selector: #selector(updateTimer))
            displayLink?.add(to: .main, forMode: .common)
        } else {
            elapsedTime += CACurrentMediaTime() - deadlineTime
            displayLink?.invalidate()
            displayLink = nil
        }
    }
    // MARK: - 更新计时
    @objc private func updateTimer() {
        let currentTime = CACurrentMediaTime()
        let totalElapsedTime = elapsedTime + (deadlineTime - currentTime)

        // 格式化时间
        let minutes = Int(totalElapsedTime) / 60
        let seconds = Int(totalElapsedTime) % 60
        let milliseconds = Int((totalElapsedTime - floor(totalElapsedTime)) * 1000)
        
        if (seconds < 0) {
            displayLink?.invalidate()
            displayLink = nil
            timerLabel.text = "00:00.00折扣结束" // 初始时间
            self.removeFromSuperview()
        } else {
            timerLabel.text = String(format: "%02d:%02d.%02d折扣结束", minutes, seconds, getFirstTwoDigits(of: milliseconds))
        }
        
        
    }
    
    
    private func getFirstTwoDigits(of number: Int) -> Int {
        let absNumber = abs(number) // 取绝对值
        
        // 如果数字小于 10，直接返回
        guard absNumber >= 10 else {
            return absNumber
        }
        
        // 计算整数的位数
        let digitCount = Int(log10(Double(absNumber))) + 1
        
        // 计算去掉多余位数的因子
        let factor = Int(pow(10.0, Double(digitCount - 2)))
        
        // 取前两位
        return absNumber / factor
    }
    
    override var intrinsicContentSize: CGSize {
        return timerLabel.intrinsicContentSize
    }

}
