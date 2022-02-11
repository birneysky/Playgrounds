//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Bruce on 2022/2/9.
//

import SwiftUI

/// this is the ViewModel of game
class EmojiMemoryGame {
    static let emojis = ["🚒", "✈️", "⛱", "⛽️", "🚕", "🚙", "🚌",
                         "🚎", "🏎", "🚓", "🚑", "🦯", "🚐", "🛻",
                         "🚚", "🚛", "🚜", "🛵", "🏍", "🛺", "🚔",
                         "🚍", "🚘", "🚝", "🚄", "🚅", "🚤", "🛥",
                         "🛳", "⛴", "🚀", "🚁", "🛬", "🛩", "🎠"]
    /// private(set) 只可读，不可写
    private var model: MemoryGame<String> =
        MemoryGame(numberOfPairsOfCards: emojis.count) { index in emojis[index] }
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
