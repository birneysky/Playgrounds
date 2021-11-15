//
//  ContentView.swift
//  Memorize
//
//  Created by birneysky on 2021/9/2.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["🚒", "✈️", "⛱", "⛽️", "🚕", "🚙", "🚌",
                  "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻",
                  "🚚", "🚛", "🚜", "🛵", "🏍", "🛺", "🚔",
                  "🚍", "🚘", "🚝", "🚄", "🚅", "🚤", "🛥",
                  "🛳", "⛴", "🚀", "🚁", "🛬", "🛩", "🎠"]
    
    @State var emojisCount = 4
    
    var body: some View {
        VStack{
            HStack {
                ForEach(emojis[0 ..< emojisCount], id: \.self) { emoji in
                    CardView(content: emoji)
                }
            }
            Spacer(minLength: 20)
            HStack {
                addButton
                Spacer()
                removeButton
            }
            .font(.largeTitle)
        }
        .padding(.horizontal)
        .foregroundColor(.red)
    }
    
    
    var removeButton: some View {
        Button(action: {
            if (emojisCount > 1) {
                emojisCount -= 1
            }
        }, label: {
            Image(systemName: "minus.circle")
        })
    }
    
    var addButton: some View {
        Button {
            if (emojisCount < self.emojis.count){
                emojisCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
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
