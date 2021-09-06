//
//  ContentView.swift
//  Memorize
//
//  Created by birneysky on 2021/9/2.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["🚒", "✈️", "⛱", "⛽️"]
    var body: some View {
        HStack{
            ForEach(emojis, id: \.self) { emoji in
                CardView(content: emoji)                
            }
        }
        .padding(.horizontal)
        .foregroundColor(.red)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
        
    }
}
