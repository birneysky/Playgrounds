//
//  Padding.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/10/6.
//

import SwiftUI

struct Padding: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("it's pretty self-explanatory. padding is literally the padding or a little space around each object. but in swift ui it is super important . because we can use padding to space objects out and also push object off the edges . ")
                .background(.orange)
                .padding()
                .background(.blue)
            Text("it's pretty self-explanatory")
                .background(.orange)
                .padding(.all, 20)
                .background(.blue)
            Text("it's pretty self-explanatory")
                .background(.orange)
                .padding(.leading, 20)
                .background(.blue)
            Text("it's pretty self-explanatory")
                .background(.orange)
                .padding(.trailing, 20)
                .background(.blue)
            
            Text("it's pretty self-explanatory")
                .background(.orange)
                .padding(.vertical, 20)
                .background(.blue)
            
            Text("it's pretty self-explanatory")
                .background(.orange)
                .padding(.horizontal, 20)
                .background(.blue)
            
        }
        
    }
}

struct Padding_Previews: PreviewProvider {
    static var previews: some View {
        Padding()
    }
}
