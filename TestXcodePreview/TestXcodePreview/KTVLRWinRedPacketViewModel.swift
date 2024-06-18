//
//  KTVLRWinRedPacketViewModel.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/6/18.
//

import UIKit







class KTVLRWinRedPacketViewModel: NSObject {
    private var model: KTVRoomRedPacketModel!
    
    enum RedPacketState {
        case distributed // 红包已分发，等待领取
        case claiming // 已参与认领红包
        case expired // 红包已过期
        case exhausted // 红包已领完
    }
    
    
    var state: KTVObservable<RedPacketState> = KTVObservable(nil)
    
    func setModel(_ model: KTVRoomRedPacketModel) {
        self.model = model
        
        if model.participants.contains("x") {
            state.value = .claiming
        } else if model.countDown > 0 {
            state.value = .distributed
        } else {
            state.value = .expired
        }
        
        
    }
    
    
    func xxx() {
        state.value = .claiming
    }
}
