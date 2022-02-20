//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Bruce on 2022/2/9.
//

import SwiftUI

/// this is the ViewModel of game
/// ObservableObject 是一个对象，可以发布有东西改变了
/// 可以通过 objectWillChange.send() 方法来发布改变
/// 或者使用属性包装器关键字 @Published 来修饰改变的变量
/// @Published 修饰的变量无论何时发生变化，任何时候任何人做任何改变模型的事情
/// 都会自动发布改变，也就是调用  objectWillChange.send() 
class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let emojis =
        ["🚒", "✈️", "⛱", "⛽️", "🚕", "🚙", "🚌",
         "🚎", "🏎", "🚓", "🚑", "🦯", "🚐", "🛻",
         "🚚", "🚛", "🚜", "🛵", "🏍", "🛺", "🚔",
         "🚍", "🚘", "🚝", "🚄", "🚅", "🚤", "🛥",
         "🛳", "⛴", "🚀", "🚁", "🛬", "🛩", "🎠"]
    /// private(set) 只可读，不可写
    @Published private var model =
        MemoryGame(numberOfPairsOfCards: 4) { index in emojis[index] }
    
    var cards: [Card] {
        return model.cards
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
