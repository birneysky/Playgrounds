//
//  CardView.swift
//  Memorize
//
//  Created by birneysky on 2021/9/2.
//

import SwiftUI

struct CardView: View {
    private let card: EmojiMemoryGame.Card

    init(_ card: EmojiMemoryGame.Card) {
        self.card = card
    }
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 8.0)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 0.5)
                Text(card.content).font(.largeTitle)
            } else if (card.isMatched) {
                shape.opacity(0)
            } else {
                shape.fill()
            }
            
        }
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(EmojiMemoryGame.Card(content: "🚕", id: 0))
            .preferredColorScheme(.dark)
        CardView(EmojiMemoryGame.Card(content: "✈️", id: 1))
            .preferredColorScheme(.light)
    }
}
