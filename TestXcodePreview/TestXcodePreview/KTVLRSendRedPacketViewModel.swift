//
//  KTVLRSendRedPacketViewModel.swift
//  TestXcodePreview
//
//  Created by Bruce on 2024/6/14.
//

import UIKit

@objc protocol KTVRedPacketTotalAmount {
    @objc var amount: Int { get }
}

@objc protocol KTVRedPacketSurvivalTime {
    @objc var time: TimeInterval { get }
}

enum ParticipationWay: String {
    case money = "pay_1" /// 金币/钻石
    case command = "word" /// 口令
}

struct KTVRedPacketParticipationWay {
    var name: String
    var type: ParticipationWay
}

class KTVRedPacketTotalAmountItem {
    var name: String
    var survialTimeItems: [Int]
    var numRange:ClosedRange<Int>
    var participationItems: [KTVRedPacketParticipationWay]
    init(name: String, survialTimeItems: [Int], numRange: ClosedRange<Int>, participationItems: [KTVRedPacketParticipationWay]) {
        self.name = name
        self.survialTimeItems = survialTimeItems
        self.numRange = numRange
        self.participationItems = participationItems
    }
}

class KTVRedPacketSurvivalTimeItem: KTVRedPacketSurvivalTime {
    private var survivalTime: TimeInterval = 0
    
    var time: TimeInterval {
        return survivalTime
    }
    
    init(survivalTime: TimeInterval) {
        self.survivalTime = survivalTime
    }
}

class KTVLRSendRedPacketData {
    var amountList: [KTVRedPacketTotalAmountItem]
    
    init(amountList: [KTVRedPacketTotalAmountItem]) {
        self.amountList = amountList
    }
}

class KTVLRSendRedPacketViewModel: NSObject {
    

    var isLoading: KTVObservable<Bool> = KTVObservable(false)
    var timeSelectIndex: KTVObservable<Int> = KTVObservable(nil)
    var amountIndex: KTVObservable<Int> = KTVObservable(nil)
    var selectedParticipationType: KTVObservable<ParticipationWay> = KTVObservable(nil)
    var selectedParticipationIndex: KTVObservable<Int> = KTVObservable(nil)
    var selectedNumRange: ClosedRange<Int>? {
        self.selectedAmount?.numRange
    }
    private var selectedAmount: KTVRedPacketTotalAmountItem? = nil
    private var selectedTime: Int? = nil
    private var dataSource: KTVLRSendRedPacketData?
    
    func selectedParticipationWay(at row: Int, in section: Int) {
        selectedParticipationType.value = self.selectedAmount?.participationItems[row].type
    }
    
    func selectAmount(at row: Int, in section: Int) {
        selectedAmount = dataSource?.amountList[row]
        selectedTime = selectedAmount?.survialTimeItems.first
        timeSelectIndex.value = 0
        selectedParticipationType.value = self.selectedAmount?.participationItems.first?.type
        selectedParticipationIndex.value = 0
        
    }
    
    func selectTime(at row: Int, in section: Int) {
        self.selectedTime = self.selectedAmount?.survialTimeItems[row]
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfAmountItems(in section: Int) -> Int {
        self.dataSource?.amountList.count ?? 0
    }
    
    
    func numberOfTimeItems(in section: Int) -> Int {
        self.selectedAmount?.survialTimeItems.count ?? 0
    }
    
    func numberOfparticipationItems(in section: Int) -> Int {
        self.selectedAmount?.participationItems.count ?? 0
    }
    
    func amoutString(at row: Int, in section: Int) -> String {
        guard let name = self.dataSource?.amountList[row].name else { fatalError() }
        return  name
    }
    
    
    
    func timeString(at row: Int, in section: Int) -> String {
        guard let time = self.selectedAmount?.survialTimeItems[row] else { fatalError() }
        return "\(time) 分钟"
    }
    
    func participationString(at row: Int, in section: Int) -> String {
        guard let name = self.selectedAmount?.participationItems[row].name else { fatalError() }
        return  name
    }
    
    
    func getData(completion:(() -> Void)? = nil, error: ((String) -> Void)? = nil) {
            
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        DispatchQueue.global().async { [weak self] in
            Thread.sleep(forTimeInterval: 1)
            
            self?.dataSource = KTVLRSendRedPacketData(amountList: [
                KTVRedPacketTotalAmountItem(name: "500 钻石/金币", survialTimeItems: [1], numRange: 2...30, participationItems: [
                    KTVRedPacketParticipationWay(name: "口令", type: .command)
                ]),
                KTVRedPacketTotalAmountItem(name: "2000 钻石/金币", survialTimeItems: [1, 3], numRange: 2...30, participationItems: [
                    KTVRedPacketParticipationWay(name: "口令", type: .command)
                ]),
                KTVRedPacketTotalAmountItem(name: "5000 钻石金币", survialTimeItems: [1, 3, 5], numRange: 2...30, participationItems: [
                    KTVRedPacketParticipationWay(name: "口令", type: .command),
                    KTVRedPacketParticipationWay(name: "1 钻石/金币", type: .money)
                ]),
                KTVRedPacketTotalAmountItem(name: "10000 钻石金币", survialTimeItems: [1, 5, 10], numRange: 2...30, participationItems: [
                    KTVRedPacketParticipationWay(name: "1 钻石/金币", type: .money),
                    KTVRedPacketParticipationWay(name: "口令", type: .command),
                ]),
            ])
            self?.selectedAmount = self?.dataSource?.amountList.first
            self?.isLoading.value = false
            self?.amountIndex.value = 0
            self?.selectedTime = self?.selectedAmount?.survialTimeItems.first
            self?.timeSelectIndex.value = self?.selectedTime != nil ? 0 : nil
            self?.selectedParticipationType.value = self?.selectedAmount?.participationItems.first?.type
            self?.selectedParticipationIndex.value = 0
        }
        
    }
}
