//
//  ContentView.swift
//  Caculator
//
//  Created by birney on 2019/12/23.
//  Copyright © 2019 rongcloud. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var brain: CalculatorBrain = .left("0")
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            Text(brain.output)
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .padding([.leading, .trailing], 24)
                .lineLimit(5)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(.black)
            Button("Test") {    // 2
                self.brain = .left("1.23")
            }
            CalculatorButtonPad(brain: $brain)
                .padding(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
           // ContentView().previewDevice("iPhone Xs").environment(\.colorScheme, .light)
            ContentView().previewDevice("iPhone SE").environment(\.colorScheme, .dark)
 //           ContentView().previewDevice("iPad Air 2")
//            ContentView().previewLayout(.fixed(width: 786, height: 414)).environment(\.colorScheme, .dark)
        }
    }
}
