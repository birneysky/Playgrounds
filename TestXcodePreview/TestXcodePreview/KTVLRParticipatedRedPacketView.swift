//
//  KTVLRParticipatedRedPacketView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/6/18.
//

import UIKit

class KTVLRParticipatedRedPacketView: UIView {

    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var numRedPacketLabel: UILabel!
    @IBOutlet weak var numPersonLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        self.countdownLabel.text = "05:13"
    }

}


#Preview("KTVLRParticipatedRedPacketView", traits: .portrait) {
    let view = KTVLRParticipatedRedPacketView.view()
    return view
}
