//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Francesco Balestrieri on 29.3.2025.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(game: EmojiMemoryGame())
        }
    }
}
