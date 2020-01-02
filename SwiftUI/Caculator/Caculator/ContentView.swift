//
//  ContentView.swift
//  Caculator
//
//  Created by birney on 2019/12/23.
//  Copyright © 2019 rongcloud. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            Text("fdsakfffdsafd")
                .font(.system(size: 76))
                .padding(.trailing, 24)
                .lineLimit(1)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            CalculatorButtonPad()
                .padding(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().previewDevice("iPhone Xs")
            .environment(\.colorScheme, .dark)
//            ContentView().previewDevice("iPhone SE").environment(\.colorScheme, .dark)
//            ContentView().previewDevice("iPad Air 2")
//            ContentView().previewLayout(.fixed(width: 786, height: 414)).environment(\.colorScheme, .dark)
        }
    }
}
