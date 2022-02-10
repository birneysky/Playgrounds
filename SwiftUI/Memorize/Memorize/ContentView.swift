//
//  ContentView.swift
//  Memorize
//
//  Created by birneysky on 2021/9/2.
//

import SwiftUI

struct ContentView: View {
    
    var viewModel: EmojiMemoryGame
    
    var emojis = ["🚒", "✈️", "⛱", "⛽️", "🚕", "🚙", "🚌",
                  "🚎", "🏎", "🚓", "🚑", "🦯", "🚐", "🛻",
                  "🚚", "🚛", "🚜", "🛵", "🏍", "🛺", "🚔",
                  "🚍", "🚘", "🚝", "🚄", "🚅", "🚤", "🛥",
                  "🛳", "⛴", "🚀", "🚁", "🛬", "🛩", "🎠"]
    
    @State var emojisCount = 11
    
    var body: some View {
        VStack{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 64))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            
            Spacer(minLength: 20)
            
            HStack {
                addButton
                Spacer()
                removeButton
            }
            .font(.largeTitle)
        }
        .padding(.horizontal)
        
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
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
        
    }
}
