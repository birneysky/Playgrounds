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
    
    func setRedPacketGift(_ gift: KTVRedPacketGift) {
        self.rewardImageView.image = UIImage(named: gift.imgURL)
        self.nameLabel.text = "\(gift.userName) 获得"
        self.avatarImageView.image = UIImage(named: gift.userAvatar)
        self.numRewardLabel.text = "\(gift.coins) 价值的 \(gift.giftName)"
    }
    
}
