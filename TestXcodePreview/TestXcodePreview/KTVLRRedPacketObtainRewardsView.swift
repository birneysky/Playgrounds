//
//  KTVLRRedPacketObtainRewardsView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/6/18.
//

import UIKit

class KTVLRRedPacketObtainRewardsView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib(nibName: "KTVLRRedPacketRewardsCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "KTVLRRedPacketRewardsCell")
    }
}



@available(iOS 17.0, *)
#Preview("KTVLRRedPacketObtainRewardsView", traits: .portrait) {
    let view = KTVLRRedPacketObtainRewardsView.view()
    return view
}
