//
//  BarView.swift
//  Examples
//
//  Created by birney on 2020/1/13.
//  Copyright © 2020 Grocery. All rights reserved.
//

import SwiftUI

struct BarView: View {
    var value: CGFloat = 0
    var week: String = ""
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Capsule().frame(width: 30, height: value)
                    .foregroundColor(Color(red: 0.6666070223, green: 0.6667048931, blue: 0.6665855646, opacity: 1))
                Capsule().frame(width: 30, height: value)
                    .foregroundColor(.white)
            }
            Text(week)
        }
    }
}

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        BarView(value: 50, week: "hello")
    }
}
