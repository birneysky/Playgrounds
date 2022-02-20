//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by birneysky on 2021/9/2.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 64))]) {
                    ForEach(game.cards) { card in
                        CardView(card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
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
        }, label: {
            Image(systemName: "minus.circle")
        })
    }
    
    var addButton: some View {
        Button {
        } label: {
            Image(systemName: "plus.circle")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
        
    }
}
