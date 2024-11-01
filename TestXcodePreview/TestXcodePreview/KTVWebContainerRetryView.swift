//
//  KTVWebContainerRetryView.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/8/15.
//

import UIKit

class KTVWebContainerRetryView: UIView {

    @IBOutlet weak var quitButton: UIButton!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override  func awakeFromNib() {
        super.awakeFromNib()
        self.quitButton.layer.cornerRadius = 20
        self.quitButton.layer.masksToBounds = true
        self.quitButton.layer.borderColor = rgba("#CCCCCCFF").cgColor
        self.quitButton.layer.borderWidth = 0.5
    }
}


@available(iOS 17.0, *)
#Preview{
    let view = KTVWebContainerRetryView.view()
    //view.backgroundColor = .red
    return view
}
