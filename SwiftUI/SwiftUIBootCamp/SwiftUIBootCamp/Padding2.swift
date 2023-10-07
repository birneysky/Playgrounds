//
//  PaddingSpacer2.swift
//  SwiftUIBootCamp
//
//  Created by Bruce on 2023/10/7.
//

import SwiftUI

struct Padding2: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.red)
                .padding(.leading, 16)
            
            VStack(alignment: .leading) {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text("this is the description of what we will do on this screen . it is multiple lines and we will algin the text to the leading edge.")
            }
            .padding()
            .background(
                Color.white
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
            )
            .padding(.horizontal, 10)
        }
        
            
        
    }
}

struct PaddingSpacer2_Previews: PreviewProvider {
    static var previews: some View {
        Padding2()
    }
}
