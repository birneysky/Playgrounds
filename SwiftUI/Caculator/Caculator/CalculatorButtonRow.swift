//
//  CalculatorButtonRow.swift
//  Caculator
//
//  Created by birney on 2019/12/23.
//  Copyright © 2019 rongcloud. All rights reserved.
//

import SwiftUI

struct CalculatorButtonRow: View {
    static let itemSpace: CGFloat = 12
    let row: [CalculatorButtonItem]
    @Binding var brain: CalculatorBrain
    var body: some View {
        //GeometryReader { geometry in
            HStack(spacing: Self.itemSpace) {
                ForEach(self.row, id: \.self) { item -> CalculatorButton in
                    //let screenWidth = geometry.size.width
                    let screenWidth = UIScreen.main.bounds.width
                    let estimateSize = CGSize(width: CGFloat(screenWidth - Self.itemSpace * 5) / CGFloat(4), height: CGFloat(screenWidth - Self.itemSpace * 5) / CGFloat(4))
                    var size = CGSize.zero
                    if case CalculatorButtonItem.digit(let value) = item, value == 0 {
                        size = CGSize(width:estimateSize.width * 2 + Self.itemSpace, height: estimateSize.height)
                    } else {
                        size = estimateSize
                    }
                    return CalculatorButton(title: item.title,
                                            size: size,
                                            backgroundName: item.backgroundColorName)
                    {
                        print("button: \(item.title)")
                        self.brain = self.brain.apply(item: item)
                    }
                }
            }
        //}
    }
}

struct CalculatorButtonRow_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButtonRow(row: [.digit(1), .digit(2), .digit(3), .op(.plus)], brain: .constant(.left("123")))
    }
}
