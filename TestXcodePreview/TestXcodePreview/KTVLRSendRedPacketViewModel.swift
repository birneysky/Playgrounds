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

class KTVRedPacketTotalAmountItem: KTVRedPacketTotalAmount {
    var amount: Int {
        return totalAmount
    }
    
    private var totalAmount: Int = 0
    
    init(totalAmount: Int) {
        self.totalAmount = totalAmount
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
    var amountList: [KTVRedPacketTotalAmount]
    var timeList: [KTVRedPacketSurvivalTime]
    
    init(amountList: [KTVRedPacketTotalAmount], timeList: [KTVRedPacketSurvivalTime]) {
        self.amountList = amountList
        self.timeList = timeList
    }
}

class KTVLRSendRedPacketViewModel: NSObject {
    
    enum ParticipationWay {
        case money /// 金币/钻石
        case command /// 口令
    }
    var isLoading: KTVObservable<Bool> = KTVObservable(false)
    var amountDataSource: KTVObservable<[KTVRedPacketTotalAmount]> = KTVObservable(nil)
    var timeDataSource: KTVObservable<[KTVRedPacketSurvivalTime]> = KTVObservable(nil)
    var participationType: KTVObservable<ParticipationWay> = KTVObservable(.money)
    private var selectedAmount: KTVRedPacketTotalAmount? = nil
    private var selectedTime: KTVRedPacketSurvivalTime? = nil
    private var dataSource: KTVLRSendRedPacketData?
    private func mapDataSource() {
        self.amountDataSource.value = self.dataSource?.amountList
        self.timeDataSource.value = self.dataSource?.timeList
        self.selectedAmount = self.amountDataSource.value?.first
        self.selectedTime = self.timeDataSource.value?.first
    }
    
    func selectedParticipationWay(_ way: ParticipationWay) {
        self.participationType.value = way
    }
    
    func selectAmount(at row: Int, in section: Int) {
        self.selectedAmount = self.amountDataSource.value?[row]
    }
    
    func selectTime(at row: Int, in section: Int) {
        self.selectedTime = self.timeDataSource.value?[row]
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfAmountItems(in section: Int) -> Int {
        self.amountDataSource.value?.count ?? 0
    }
    
    
    func numberOfTimeItems(in section: Int) -> Int {
        self.timeDataSource.value?.count ?? 0
    }
    
    func amoutString(at row: Int, in section: Int) -> String {
        guard let amount = self.amountDataSource.value?[row].amount else { fatalError() }
        return "\(amount) 钻石/金币"
    }
    
    
    
    func timeString(at row: Int, in section: Int) -> String {
        guard let time = self.timeDataSource.value?[row].time else { fatalError() }
        return "\(Int(time / 60)) 分钟"
    }
    
    
    func getData(completion:(() -> Void)? = nil, error: ((String) -> Void)? = nil) {
            
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        DispatchQueue.global().async { [weak self] in
            Thread.sleep(forTimeInterval: 1)
            self?.isLoading.value = false
            self?.dataSource = KTVLRSendRedPacketData(amountList: [
                KTVRedPacketTotalAmountItem(totalAmount: 100),
                KTVRedPacketTotalAmountItem(totalAmount: 400),
                KTVRedPacketTotalAmountItem(totalAmount: 500),
                KTVRedPacketTotalAmountItem(totalAmount: 600),
                KTVRedPacketTotalAmountItem(totalAmount: 800),
            ], timeList: [
                KTVRedPacketSurvivalTimeItem(survivalTime: 60),
                KTVRedPacketSurvivalTimeItem(survivalTime: 60 * 2),
                KTVRedPacketSurvivalTimeItem(survivalTime: 60 * 3),
                KTVRedPacketSurvivalTimeItem(survivalTime: 60 * 4),
                KTVRedPacketSurvivalTimeItem(survivalTime: 60 * 5),
            ])
            self?.mapDataSource()
        }
        
    }
}
