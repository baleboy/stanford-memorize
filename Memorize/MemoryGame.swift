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
    
    private var indexOfcurrentlyTurnedUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                cards[chosenIndex].isFaceUp = true
                if let turned = indexOfcurrentlyTurnedUpCard {
                    if cards[turned].content == cards[chosenIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[turned].isMatched = true
                        indexOfcurrentlyTurnedUpCard = nil
                    } else {
                        cards[turned].isFaceUp = false
                        cards[chosenIndex].isFaceUp = true
                        indexOfcurrentlyTurnedUpCard = chosenIndex
                    }
                } else {
                    cards[chosenIndex].isFaceUp = true
                    indexOfcurrentlyTurnedUpCard = chosenIndex
                }
            }

        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable {
        let id: UUID = UUID()
        var content: CardContent
        var isFaceUp: Bool = false
        var isMatched: Bool = false
    }
}
