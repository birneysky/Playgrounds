//
//  MemorizeApp.swift
//  Memorize
//
//  Created by birneysky on 2021/9/2.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
