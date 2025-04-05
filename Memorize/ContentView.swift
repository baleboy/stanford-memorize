//
//  ContentView.swift
//  Memorize
//
//  Created by Francesco Balestrieri on 29.3.2025.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var game: EmojiMemoryGame

    var body: some View {
        VStack {
            title
            ScrollView {
                cards
                    .animation(.default, value: game.cards)
            }
            if !game.isGameOver {
                Button("Shuffle") {
                    game.shuffle()
                }
            } else {
                Button("Reset") {
                    game.reset()
                }
            }
        }
        .padding()
    }

    var title: some View {
        Text("Memorize!").font(.largeTitle)
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(game.cards) { card in
                CardView(card)
                    .aspectRatio(2 / 3, contentMode: .fit)
                    .onTapGesture {
                        game.choose(card)
                    }
                    .rotation3DEffect(
                         Angle.degrees(card.isFaceUp ? 0 : 180),
                         axis: (x: 0, y: 1, z: 0)
                     )
                    .animation(.easeInOut(duration: 0.2), value: card.isFaceUp)
            }
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card)
    {
        self.card = card
    }
    
    var body: some View {
        let base = RoundedRectangle(cornerRadius: 20)
        ZStack {
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content).font(.largeTitle)
            }.opacity(card.isFaceUp ? 1 : 0)
            base.fill(.orange).opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isMatched ? 0 : 1)
    }
}
    
#Preview {
    ContentView(game: EmojiMemoryGame())
}
