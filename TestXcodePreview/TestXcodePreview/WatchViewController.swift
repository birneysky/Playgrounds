//
//  WatchViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/12/17.
//

import UIKit

class PurchaseCountDownView: UIView {
    private var timerLabel: UILabel!        // 显示计时的标签
    private var startTime: TimeInterval
    private var elapsedTime: TimeInterval = 0 // 累计时间
    private var displayLink: CADisplayLink? // 用于高精度计时的定时器
    
    ///startTime 单位 ms
    init(startTime: TimeInterval) {
        self.startTime = startTime / 1000.0
        super.init(frame: .zero)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("unsupport xib")
    }
    
    private func setup() {
        // 创建计时标签
        timerLabel = UILabel()
        timerLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 12, weight: .regular) // 使用等宽字体
        timerLabel.textAlignment = .center
        timerLabel.text = "00:10.00折扣结束" // 初始时间
        addSubview(timerLabel)
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
            elapsedTime += CACurrentMediaTime() - startTime
            displayLink?.invalidate()
            displayLink = nil
        }
    }
    // MARK: - 更新计时
    @objc private func updateTimer() {
        let currentTime = CACurrentMediaTime()
        let totalElapsedTime = elapsedTime + (startTime - currentTime)

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


class WatchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private var timerLabel: UILabel!        // 显示计时的标签
    private var startPauseButton: UIButton! // 开始/暂停按钮
    private var resetButton: UIButton!      // 重置按钮
    
    private var displayLink: CADisplayLink? // 用于高精度计时的定时器
    private var startTime: TimeInterval?    // 记录开始时间
    private var elapsedTime: TimeInterval = 0 // 累计时间
    
    private var countDownView: PurchaseCountDownView!
    private var collectionView: UICollectionView!
    private var dataSource: [WatchCountDownModel] = [
        WatchCountDownModel(discountCountDown: true,  idx: "0"),
        WatchCountDownModel(discountCountDown: false, idx: "1"),
        WatchCountDownModel(discountCountDown: false, idx: "2"),
        WatchCountDownModel(discountCountDown: false, idx: "3"),
        WatchCountDownModel(discountCountDown: false, idx: "4"),
        WatchCountDownModel(discountCountDown: false, idx: "5"),
        WatchCountDownModel(discountCountDown: false, idx: "6"),
        WatchCountDownModel(discountCountDown: false, idx: "7"),
        WatchCountDownModel(discountCountDown: false, idx: "8"),
        WatchCountDownModel(discountCountDown: false, idx: "9"),
        WatchCountDownModel(discountCountDown: false, idx: "10"),
    ]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
        
    // MARK: - 设置界面
    private func setupUI() {
        view.backgroundColor = .white
        
        // 创建计时标签
//        timerLabel = UILabel()
//        timerLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 48, weight: .medium) // 使用等宽字体
//        timerLabel.textAlignment = .center
//        timerLabel.text = "00:10.00" // 初始时间
//        timerLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(timerLabel)
        
//        countDownView = PurchaseCountDownView()
//        countDownView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(countDownView)
        
//        // 开始/暂停按钮
//        startPauseButton = UIButton(type: .system)
//        startPauseButton.setTitle("开始", for: .normal)
//        startPauseButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
//        startPauseButton.addTarget(self, action: #selector(toggleTimer), for: .touchUpInside)
//        startPauseButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(startPauseButton)
//        
//        // 重置按钮
//        resetButton = UIButton(type: .system)
//        resetButton.setTitle("重置", for: .normal)
//        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
//        resetButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
//        resetButton.isEnabled = false // 初始状态禁用
//        resetButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(resetButton)
//        
//        // 添加布局约束
//        NSLayoutConstraint.activate([
//            countDownView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            countDownView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
//            
//            startPauseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
//            startPauseButton.topAnchor.constraint(equalTo: countDownView.bottomAnchor, constant: 50),
//            
//            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
//            resetButton.topAnchor.constraint(equalTo: countDownView.bottomAnchor, constant: 50)
//        ])
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 112, height: 132)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .green
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 160)
        ])
        
        collectionView.register(WatchCountDownCell.self, forCellWithReuseIdentifier: "MyCellIdentifier")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCellIdentifier", for: indexPath) as! WatchCountDownCell
        cell.backgroundColor = UIColor.blue
        let model = self.dataSource[indexPath.item]
        if model.discountCountDown && indexPath.item == 0, let isRuning = model.countdownRuning {
            var startTime: Double = Double(getCountdownCountDeadline(model.idx))
            let duration:Double = 120 * 1000
            let current = CACurrentMediaTime() * 1000
            if startTime == 0 || current > startTime  {
                startTime = current + duration
                setCountdownDeadline(model.idx, Int(startTime))
            }
            cell.setCoundownViewStartTime(startTime: startTime)
//            cell.setCoundownViewShowing(show: true)
        }
        return cell
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! WatchCountDownCell
        let model = self.dataSource[indexPath.item]
        if model.discountCountDown && indexPath.item == 0 {
            model.countdownRuning = true
            var startTime: Double = Double(getCountdownCountDeadline(model.idx))
            let duration:Double = 120 * 1000
            let current = CACurrentMediaTime() * 1000
            if startTime == 0 || current > startTime  {
                startTime = current + duration
                setCountdownDeadline(model.idx, Int(startTime))
            }
            cell.setCoundownViewStartTime(startTime: startTime)
        }
    }
    
    // MARK: - 开始/暂停计时
    @objc private func toggleTimer() {
        countDownView.toggleTimer()
    }
    
    // MARK: - 重置计时
    @objc private func resetTimer() {
//        elapsedTime = 0
//        startTime = nil
//        timerLabel.text = "00:00.00"
//        resetButton.isEnabled = false
    }
}


@available(iOS 17.0, *)
#Preview{
    return WatchViewController();
}
