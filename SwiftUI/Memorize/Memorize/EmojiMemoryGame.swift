//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Bruce on 2022/2/9.
//

import SwiftUI

func makeCardContent(index: Int) -> String {
    return "😅"
}

/// this is the ViewModel of game
class EmojiMemoryGame {
    /// private(set) 只可读，不可写
    private var model: MemoryGame<String> =
        MemoryGame(numberOfPairsOfCards: 6, createCardContent: makeCardContent)
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
}
