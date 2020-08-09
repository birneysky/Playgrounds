//
//  CaculatorModel.swift
//  Caculator
//
//  Created by birneysky on 2020/8/9.
//  Copyright © 2020 rongcloud. All rights reserved.
//

import Combine

class CaculatorModel: ObservableObject {
    
    @Published var brain: CalculatorBrain = .left("0")
}
