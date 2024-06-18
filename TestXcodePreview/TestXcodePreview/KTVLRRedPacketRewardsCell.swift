//
//  KTVLRRedPacketRewardsCell.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/6/18.
//

import UIKit

class KTVLRRedPacketRewardsCell: UITableViewCell {

    @IBOutlet weak var rewardImageView: UIImageView!
    @IBOutlet weak var numRewardLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
