//
//  KTVLRRedPacketRewardsTableView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/6/18.
//

import UIKit

class KTVLRRedPacketRewardsTableView: UIView {

    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib(nibName: "KTVLRRedPacketRewardsCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "KTVLRRedPacketRewardsCell")
    }
    
}



#Preview("KTVLRRedPacketRewardsTableView", traits: .portrait) {
    let view = KTVLRRedPacketRewardsTableView.view()
    return view
}
