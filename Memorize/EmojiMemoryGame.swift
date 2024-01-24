//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Daniel Kim on 2024-01-03.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    private static var themes: [EmojiTheme] = []
    private static let halloweenEmojis = ["👻","🎃","🕷️","😈","💀","🧙"]
    private static let xmasEmojis: Array<String> = ["🎅","🦌","🎄","🎁","⛄️","❄️"]
    private static let beachEmojis: Array<String> = ["🌊","☀️","🐚","🏖️","🦀","🩴"]
    private static let schoolEmojis: Array<String> =
        ["📚","🏫","✏️","🚌","🎓","➗"]
    private static let artEmojis: Array<String> =
        ["📚","🏫","✏️","🚌","🎓","➗"]
    private static let partyEmojis: Array<String> =
        ["📚","🏫","✏️","🚌","🎓","➗"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        
        createThemes()
        
        return MemoryGame(numberOfPairsOfCards: themes[0].numPairs) { pairIndex in
            if themes[0].emojis.indices.contains(pairIndex) {
                return themes[0].emojis[pairIndex]
            } else {
                return "😅"
            }
        }
    }
    
    private static func createThemes() {
        themes.append(EmojiTheme(name: "Halloween", emojis: EmojiMemoryGame.halloweenEmojis, numPairs: 2, color: .orange))
        themes.append(EmojiTheme(name: "Christmas", emojis: EmojiMemoryGame.xmasEmojis, numPairs: 4, color: .green))
        themes.append(EmojiTheme(name: "Beach", emojis: EmojiMemoryGame.beachEmojis, numPairs: 2, color: .blue))
        themes.append(EmojiTheme(name: "School", emojis: EmojiMemoryGame.schoolEmojis, numPairs: 6, color: .black))
        themes.append(EmojiTheme(name: "Art", emojis: EmojiMemoryGame.artEmojis, numPairs: 6, color: .brown))
        themes.append(EmojiTheme(name: "Party", emojis: EmojiMemoryGame.partyEmojis, numPairs: 6, color: .yellow))
        themes.shuffle()
    }
        
    @Published private var game = createMemoryGame()
    
    
    var cards: Array<MemoryGame<String>.Card> {
        return game.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        game.shuffle()
    }
    
    func newGame() {
        EmojiMemoryGame.themes.shuffle()
        game.newGame(numberOfPairsOfCards: EmojiMemoryGame.themes[0].numPairs) { pairIndex in
            if EmojiMemoryGame.themes[0].emojis.indices.contains(pairIndex) {
                return EmojiMemoryGame.themes[0].emojis[pairIndex]
            } else {
                return "😅"
            }
        }
    }
    
    func getThemeName() -> String {
        EmojiMemoryGame.themes[0].name
    }
    
    func getThemeColor() -> Color {
        EmojiMemoryGame.themes[0].color
    }
    
    func getScore() -> Int {
        game.score
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        game.choose(card)
    }

}
