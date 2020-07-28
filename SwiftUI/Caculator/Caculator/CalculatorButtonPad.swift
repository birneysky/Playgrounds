//
//  CalculatorButtonPad.swift
//  Caculator
//
//  Created by birney on 2019/12/23.
//  Copyright © 2019 rongcloud. All rights reserved.
//

import SwiftUI

struct CalculatorButtonPad: View {
    @Binding var brain: CalculatorBrain
    let pad: [[CalculatorButtonItem]] = [
        [.command(.clear), .command(.flip), .command(.percent), .op(.divide)],
        [.digit(7), .digit(8), .digit(9), .op(.multiply)],
        [.digit(4), .digit(5), .digit(6), .op(.minus)],
        [.digit(1), .digit(2), .digit(3), .op(.plus)],
        [.digit(0), .dot, .op(.multiply)],
    ]
    var body: some View {
        VStack(spacing: 8) {
            ForEach(pad, id: \.self) { row in
                CalculatorButtonRow(row: row,brain: self.$brain)
            }
        }
    }
}

struct CalculatorButtonPad_Previews: PreviewProvider {
    
    static var previews: some View {
        CalculatorButtonPad(brain: .constant(.left("123")))
    }
}
