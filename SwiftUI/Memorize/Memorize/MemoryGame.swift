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
    
    private var indexOfTheOneAndOnlyFaceupCard: Int?
    
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
                indexOfTheOneAndOnlyFaceupCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceupCard = chooseIndex
            }
            cards[chooseIndex].isFaceUp.toggle()
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
