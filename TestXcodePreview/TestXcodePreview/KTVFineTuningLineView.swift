//
//  KTVFineTuningLineView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/7/23.
//

import UIKit

enum KTVFineTuningLineViewStyle {
    case begin
    case end
}

class KTVFineTuningLineView: UIView {

    var style: KTVFineTuningLineViewStyle = .begin {
        didSet {
            switch style {
            case .begin:
                self.endView.isHidden = true
                self.beginView.isHidden = false
            case .end:
                self.endView.isHidden = false
                self.beginView.isHidden = true
            }
        }
    }

    @IBOutlet weak var endView: UIStackView!
    @IBOutlet weak var beginView: UIStackView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    @IBAction func increaseAction(_ sender: UIButton) {
        print("-------- +++++")
    }
    
    @IBAction func decreaseAction(_ sender: UIButton) {
        print("-------- jianjian")
    }
}
