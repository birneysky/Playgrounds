//
//  KTVFineTuningLineView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/7/23.
//

import UIKit


class KTVFineTuningLineView: UIView {

    var style: KTVFineTuningLineViewStyle = .begin {
        didSet {
            switch style {
            case .begin:
                self.endView.isHidden = true
                self.beginView.isHidden = false
                self.endTimeLabel.isHidden = true
                self.startTimeLabel.isHidden = false
            case .end:
                self.endView.isHidden = false
                self.beginView.isHidden = true
                self.endTimeLabel.isHidden = false
                self.startTimeLabel.isHidden = true
            }
        }
    }

    @IBOutlet weak var endView: UIStackView!
    @IBOutlet weak var beginView: UIStackView!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    var increase: (()->Void)?
    var decrease: (()->Void)?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func formatTime(fromMilliseconds totalMilliseconds: TimeInterval) -> String {
        let totalSeconds = Int(totalMilliseconds / 1000)
        let minutes = totalSeconds / 60
        let remainSeconds = Int((totalMilliseconds - TimeInterval(minutes * 60 * 1000))/1000)
        let seconds = remainSeconds  % 60
        
        let remainMilliseconds = totalMilliseconds - TimeInterval(minutes*60*1000) - TimeInterval(seconds * 1000)
        let tenths = Int(remainMilliseconds / 10.0)
        
        
        let formattedMinutes = String(format: "%02d", minutes)
        let formattedSeconds = String(format: "%02d", seconds)
        let formattedTenths = String(format: "%02d", tenths)
        
        return "\(formattedMinutes):\(formattedSeconds):\(formattedTenths)0"
    }
    
    func setTime(_ time: TimeInterval) {
        switch style {
        case .begin:
            self.startTimeLabel.text = formatTime(fromMilliseconds: time)
        case .end:
            self.endTimeLabel.text = formatTime(fromMilliseconds: time)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    @IBAction func increaseAction(_ sender: UIButton) {
        print("-------- +++++")
        increase?()
    }
    
    @IBAction func decreaseAction(_ sender: UIButton) {
        print("-------- jianjian")
        decrease?()
    }
}
