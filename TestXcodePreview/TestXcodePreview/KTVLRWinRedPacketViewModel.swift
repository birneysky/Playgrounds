//
//  KTVLRWinRedPacketViewModel.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/6/18.
//

import UIKit



class KTVRedPacketGift: NSObject {
    var userName: String
    var userAvatar: String
    var giftName: String
    var imgURL: String
    var coins: Int
    var num: Int
    
    init(userName: String, userAvatar: String, giftName: String, imgURL: String, coins: Int, num: Int) {
        self.userName = userName
        self.userAvatar = userAvatar
        self.giftName = giftName
        self.imgURL = imgURL
        self.coins = coins
        self.num = num
    }
}

class KTVWonRedPacketInfo: NSObject {
    var participants:[String]
    var giftList:[KTVRedPacketGift]
    var filterParticipants: Bool
    init(participants: [String], giftList: [KTVRedPacketGift], filterParticipants: Bool) {
        self.participants = participants
        self.giftList = giftList
        self.filterParticipants = filterParticipants
    }
}



class KTVLRWinRedPacketViewModel: NSObject {
    private var model: KTVRoomRedPacketModel!
    private var wonRedPacketInfo: KTVWonRedPacketInfo!
    enum RedPacketState {
        case distributed // 红包已分发，等待领取
        case claiming // 已参与认领红包
        case expired // 红包已过期
        case won /// 已中奖
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
    
    
    func claimRedPacket() {
        state.value = .claiming
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.setWonRedPacketInfo(KTVWonRedPacketInfo(participants: [
                "382109392183", "4382104","x"], giftList: [
                KTVRedPacketGift(userName: "hahhaha", userAvatar: "my_group", giftName: "洋娃娃", imgURL: "like_test", coins: 100, num: 1),
                KTVRedPacketGift(userName: "hahhaha", userAvatar: "my_group", giftName: "洋娃娃", imgURL: "like_test", coins: 100, num: 1),
                KTVRedPacketGift(userName: "hahhaha", userAvatar: "my_group", giftName: "洋娃娃", imgURL: "like_test", coins: 100, num: 1),
                KTVRedPacketGift(userName: "hahhaha", userAvatar: "my_group", giftName: "洋娃娃", imgURL: "like_test", coins: 100, num: 1),
                KTVRedPacketGift(userName: "hahhaha", userAvatar: "my_group", giftName: "洋娃娃", imgURL: "like_test", coins: 100, num: 1),
                KTVRedPacketGift(userName: "hahhaha", userAvatar: "my_group", giftName: "洋娃娃", imgURL: "like_test", coins: 100, num: 1),
                KTVRedPacketGift(userName: "hahhaha", userAvatar: "my_group", giftName: "洋娃娃", imgURL: "like_test", coins: 100, num: 1),
                KTVRedPacketGift(userName: "hahhaha", userAvatar: "my_group", giftName: "洋娃娃", imgURL: "like_test", coins: 100, num: 1),
                KTVRedPacketGift(userName: "hahhaha", userAvatar: "my_group", giftName: "洋娃娃", imgURL: "like_test", coins: 100, num: 1),
                KTVRedPacketGift(userName: "hahhaha", userAvatar: "my_group", giftName: "洋娃娃", imgURL: "like_test", coins: 100, num: 1),
                KTVRedPacketGift(userName: "hahhaha", userAvatar: "my_group", giftName: "洋娃娃", imgURL: "like_test", coins: 100, num: 1),
                KTVRedPacketGift(userName: "hahhaha", userAvatar: "my_group", giftName: "洋娃娃", imgURL: "like_test", coins: 100, num: 1),
                KTVRedPacketGift(userName: "hahhaha", userAvatar: "my_group", giftName: "洋娃娃", imgURL: "like_test", coins: 100, num: 1),
                KTVRedPacketGift(userName: "hahhaha", userAvatar: "my_group", giftName: "洋娃娃", imgURL: "like_test", coins: 100, num: 1),
                KTVRedPacketGift(userName: "hahhaha", userAvatar: "my_group", giftName: "洋娃娃", imgURL: "like_test", coins: 100, num: 1),
            ], filterParticipants: true))
        }
    }
    
    func numRedPackeGift() -> Int {
        wonRedPacketInfo.giftList.count
    }
    
    func redPacketGift(in row:Int) -> KTVRedPacketGift {
        wonRedPacketInfo.giftList[row]
    }
   
    
    func setWonRedPacketInfo(_ info: KTVWonRedPacketInfo) {
        wonRedPacketInfo = info
        if info.filterParticipants, info.participants.contains("x") {
            state.value = .won
        } else {
            state.value = .exhausted
        }
    }


}
