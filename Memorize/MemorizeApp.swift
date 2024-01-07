//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Daniel Kim on 2024-01-02.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
