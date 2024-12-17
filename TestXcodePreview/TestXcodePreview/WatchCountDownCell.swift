//
//  WatchCountDownCell.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/12/17.
//

import UIKit

class WatchCountDownCell: UICollectionViewCell {
    var countDownView: PurchaseCountDownView?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        countDownView?.removeFromSuperview()
    }
    
    func setCoundownViewStartTime(startTime: TimeInterval) {
        countDownView?.removeFromSuperview()            
        let cdView = PurchaseCountDownView(startTime: startTime)
        contentView.addSubview(cdView)
        cdView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cdView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cdView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cdView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        cdView.toggleTimer()
        countDownView  = cdView
    }
    
}
