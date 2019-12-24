//
//  TestView.swift
//  Caculator
//
//  Created by birney on 2019/12/24.
//  Copyright © 2019 rongcloud. All rights reserved.
//

import SwiftUI

struct CircleButton: View {
    let title: String
    var body: some View {
        Button(action: {
        }) {
            ZStack {
                    Circle()
                        .foregroundColor(Color.orange)
                    Text(title)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
        }
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton(title: "+").previewLayout(.fixed(width: 786, height: 414))
    }
}
