//
//  MemoryGame.swift
//  Memorize
//
//  Created by Francesco Balestrieri on 2.4.2025.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    init(numberOfPairs: Int, contentFactory: (Int) -> CardContent) {
        assert(numberOfPairs > 0, "Number of pairs must be positive")
        cards = []
        for pairIndex in 0..<numberOfPairs {
            let content = contentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    mutating func choose(_ card: Card) {
        if let index = cards.firstIndex(where: {$0.id == card.id}) {
            cards[index].isFaceUp.toggle()
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable {
        let id: UUID = UUID()
        var content: CardContent
        var isFaceUp: Bool = true
        var isMatched: Bool = false
    }
}
