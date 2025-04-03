//
//  ContentView.swift
//  Memorize
//
//  Created by Francesco Balestrieri on 29.3.2025.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var game: EmojiMemoryGame

    enum Theme {
        case halloween
        case animals
        case vehicles
    }

    var body: some View {
        VStack {
            title
            ScrollView {
                cards
            }
            Button("Shuffle") {
                game.shuffle()
            }
        }
        .padding()
    }

    var title: some View {
        Text("Memorize!").font(.largeTitle)
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))]) {
            ForEach(game.cards.indices, id: \.self) { index in
                CardView(card: game.cards[index])
                    .aspectRatio(2 / 3, contentMode: .fit)
            }
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
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
    }
}
    
#Preview {
    ContentView(game: EmojiMemoryGame())
}
