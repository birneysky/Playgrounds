//
//  KTVLRRedPacketEntranceViewController.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/6/17.
//

import UIKit

class KTVLRRedPacketEntranceViewController: UIViewController {

    @IBOutlet weak var countDowLabel: UILabel!
    private var timer: Timer?
    var duration: TimeInterval = 60 * 1 + 20
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let timePoint = formatTime(seconds: Int(duration))
        self.countDowLabel.text = "\(timePoint.minutes):\(timePoint.seconds)"
        startTimer()
    }

    private func formatTime(seconds: Int) -> (minutes: Int, seconds: Int) {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return (minutes, remainingSeconds)
    }

    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        print("do something")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc private  func autoScroll() {
        duration = duration - 1
        print("----------------x")
        if duration <= 0 {
            stopTimer()
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
        
        let timePoint = formatTime(seconds: Int(duration))
        self.countDowLabel.text = "\(String(format: "%02d", timePoint.minutes)):\(String(format: "%02d", timePoint.seconds))"
    }

    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
        guard let t = timer else { fatalError() }
        RunLoop.current.add(t, forMode: .common)
    }
    
    
    private func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
}


#Preview {
    let parentController = UIViewController()
    let controller = KTVLRRedPacketEntranceViewController.controller()
    parentController.addChild(controller)
    parentController.view.addSubview(controller.view)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        controller.view.centerXAnchor.constraint(equalTo: parentController.view.centerXAnchor),
        controller.view.centerYAnchor.constraint(equalTo: parentController.view.centerYAnchor),
        controller.view.widthAnchor.constraint(equalToConstant: 34),
        controller.view.heightAnchor.constraint(equalToConstant: 42),
    ])
    return parentController;
}
