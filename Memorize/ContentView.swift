//
//  ContentView.swift
//  Memorize
//
//  Created by Francesco Balestrieri on 29.3.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var emojis: [String] = []
    
    enum Theme {
        case halloween
        case animals
        case vehicles
    }
    
    var body: some View {
        VStack {
            title
            if emojis.isEmpty {
                Spacer()
                Text("Choose a theme!").font(.headline)
            }
            cards
            Spacer()
            themeSelector
        }
        .padding()
    }
    
    var title: some View {
        Text("Memorize!").font(.largeTitle)
    }
    
    var cards: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))]) {
                ForEach(Array(emojis.enumerated()), id: \.offset) { index, emoji in
                    CardView(emoji: emoji)
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
        }
    }
    
    func themeSelectionButton(theme: Theme) -> some View {
        
        let halloweenTheme = ["💀", "🎃", "👻", "☠️", "🧛‍♂️"]
        let animalsTheme = ["🐶", "🐱", "🐭", "🐹", "🐰"]
        let vehiclesTheme = ["🚗", "🚕", "🚙", "🚚", "🚀"]
        
        var themeEmojis: [String] = []
        var iconName: String
        var themeName: String
        
        switch theme {
            case .halloween:
            themeEmojis = halloweenTheme
            iconName = "moon.fill"
            themeName = "Halloween"
        case .animals:
            themeEmojis = animalsTheme
            iconName = "cat.fill"
            themeName = "Animals"
        case .vehicles:
            themeEmojis = vehiclesTheme
            iconName = "car.fill"
            themeName = "Vehicles"
        }
        
        return Button {
            emojis = themeEmojis.shuffled() + themeEmojis.shuffled()
        } label: {
            VStack {
                Image(systemName: iconName)
                Text(themeName)
            }
        }
    }
    
    var themeSelector: some View {
        HStack {
            themeSelectionButton(theme: .halloween)
            Spacer()
            themeSelectionButton(theme: .animals)
            Spacer()
            themeSelectionButton(theme: .vehicles)
        }
    }
}

struct CardView: View {
    var emoji: String
    @State private var isFaceUp = true
    var body: some View {
        let base = RoundedRectangle(cornerRadius: 20)
        ZStack {
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(emoji).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill(.orange).opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            self.isFaceUp.toggle()
        }
    }
}
#Preview {
    ContentView()
}
