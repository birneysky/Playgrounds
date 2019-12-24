//
//  CalculatorButton.swift
//  Caculator
//
//  Created by birney on 2019/12/23.
//  Copyright © 2019 rongcloud. All rights reserved.
//

import SwiftUI

struct CalculatorButton: View {
    let fontSize: CGFloat = 38
    let title: String
    let size: CGSize
    let backgroundName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: fontSize))
                .foregroundColor(.white)
                .frame(width: size.width, height: size.height)
                .background(Color(backgroundName))
                .cornerRadius(size.width / 2)
        }
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton(title: "+", size: CGSize(width: 88, height: 88), backgroundName: "operatorBackground") {
            print("button +")
        }
    }
}
