//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Daniel Kim on 2024-01-03.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["👻","🎃","🕷️","😈","💀","🧙"]
    private static let xmasEmojis: Array<String> = ["🎅","🦌","🎄","🎁","⛄️","❄️"]
    private static let beachEmojis: Array<String> = ["🌊","☀️","🐚","🏖️","🦀","🩴"]
    private static let schoolEmojis: Array<String> =
        ["📚🏫✏️🚌🎓➗"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 6) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "😅"
            }
        }
    }
        
    @Published private var game = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return game.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        game.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        game.choose(card)
    }
}
