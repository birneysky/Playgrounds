//
//  CardView.swift
//  Memorize
//
//  Created by birneysky on 2021/9/2.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 8.0)
            if !card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 0.5)
                Text(card.content).font(.largeTitle)
            } else {
                shape.fill()
            }
            
        }
        .onTapGesture {
            
        }
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: MemoryGame<String>.Card(content: "🚕", id: 0))
            .preferredColorScheme(.dark)
        CardView(card: MemoryGame<String>.Card(content: "✈️", id: 1))
            .preferredColorScheme(.light)
    }
}
