//
//  WatchCountDownModel.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/12/17.
//

import UIKit

class WatchCountDownModel: NSObject {
    var discountCountDown: Bool
    var idx: String
    var countdownRuning: Bool?
    
    init(discountCountDown: Bool, idx: String) {
        self.discountCountDown = discountCountDown
        self.idx = idx
    }
}
