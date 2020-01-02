//
//  Hello.swift
//  Examples
//
//  Created by birneysky on 2020/1/1.
//  Copyright © 2020 Grocery. All rights reserved.
//

import SwiftUI

struct Hello: View {
    // https://uigradients.com
    let gradient: LinearGradient = LinearGradient(gradient: Gradient(colors: [Color("darkRed"), Color("darkBlue")]),
                                                  startPoint: .init(x: 0, y: 0),
                                                  endPoint: .init(x: 1, y: 0))
    
    
    
    var body: some View {
        HStack {
            Text("Hello, 2020 ▶︎ ")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .background(gradient)
                .cornerRadius(40)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 46)
                        .stroke(gradient, lineWidth: 5)
            )
        }
    }
    
    
    
}

struct Hello_Previews: PreviewProvider {
    static var previews: some View {
        Hello().previewLayout(.fixed(width: 320, height: 640))
    }
}
