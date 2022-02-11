//
//  MemoryGame.swift
//  Memorize
//
//  Created by Bruce on 2022/2/8.
//

import Foundation

/// this is the model of game
struct MemoryGame <CardContent> {
    /// private(set) 只可读，不可写
    private(set) var cards: [Card]
    
    mutating func choose(_ card: Card) {
        let chooseIndex = card.id
        cards[chooseIndex].isFaceUp.toggle()
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = [Card]()
        /// add numberOfPairsOfCards * 2 cards to cards array
        for pairIndex in 0 ..< numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
