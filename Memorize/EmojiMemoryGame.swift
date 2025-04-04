//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Francesco Balestrieri on 2.4.2025.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {

    static private let emojis = ["💀", "🎃", "👻", "☠️", "🧛‍♂️","🐶", "🐱", "🐭", "🐹", "🐰", "🚗", "🚕", "🚙", "🚚", "🚀"]

    static private func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairs: 6) { pairIndex in
            guard pairIndex < EmojiMemoryGame.emojis.count else {
                return "⁉️"
            }
            return EmojiMemoryGame.emojis[pairIndex]
        }
    }
    
    @Published private var game = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        game.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        game.choose(card)
    }
    
    func shuffle() {
        game.shuffle()
    }
}
