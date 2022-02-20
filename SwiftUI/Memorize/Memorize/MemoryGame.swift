//
//  MemoryGame.swift
//  Memorize
//
//  Created by Bruce on 2022/2/8.
//

import Foundation

/// this is the model of game
struct MemoryGame <CardContent> where CardContent: Equatable {
    /// private(set) 只可读，不可写
    private(set) var cards: [Card]
    
    private var indexOfTheOneAndOnlyFaceupCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = $0 == newValue } }
    }
    
    mutating func choose(_ card: Card) {
        /// if let chooseIndex = index(of: card)
        if let chooseIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[chooseIndex].isFaceUp,
           !cards[chooseIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceupCard {
                if cards[chooseIndex].content == cards[potentialMatchIndex].content {
                    cards[chooseIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chooseIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceupCard = chooseIndex
            }
            
        }
    }
    
    func index(of card: Card) -> Int? {
        for index in 0 ..< cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        /// add numberOfPairsOfCards * 2 cards to cards array
        for pairIndex in 0 ..< numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp  = false
        var isMatched = false
        let content: CardContent
        let id: Int
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
