//
//  UserData.swift
//  SwfitUI
//
//  Created by birney on 2019/7/2.
//  Copyright © 2019 COOL. All rights reserved.
//

import SwiftUI
import Combine

/// 当客户端更新 model 时，对于一个 BindableObject 来说，需要通知它的订阅者
final class UserData: Combine.ObservableObject, Swift.Identifiable {
    let didChange = PassthroughSubject<UserData, Never>()
    var showFavoritesOnly = false {
        didSet {
            didChange.send(self)
        }
    }
    var landmarks = landmarkData {
        didSet {
            didChange.send(self)
        }
    }
    
}
