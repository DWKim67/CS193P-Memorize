//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Daniel Kim on 2024-01-03.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    private let themeCount = 6
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
        
        return MemoryGame {
            var themePackage: [MemoryGame<String>.Theme] = []
            themePackage.append(MemoryGame<String>.Theme(name: "Halloween", emojis: halloweenEmojis, numPairs: 6, color: "orange"))
            themePackage.append(MemoryGame<String>.Theme(name: "Christmas", emojis: xmasEmojis, numPairs: 4, color: "green"))
            themePackage.append(MemoryGame<String>.Theme(name: "Beach", emojis: beachEmojis, numPairs: 6, color: "blue"))
            themePackage.append(MemoryGame<String>.Theme(name: "School", emojis: schoolEmojis, numPairs: 5, color: "black"))
            themePackage.append(MemoryGame<String>.Theme(name: "Art", emojis: artEmojis, numPairs: 6, color: "brown"))
            themePackage.append(MemoryGame<String>.Theme(name: "Party", emojis: partyEmojis, numPairs: 6, color: "yellow"))
            
            return themePackage
        }
        
        /*
        
        return MemoryGame(numberOfPairsOfCards: 6) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "😅"
            }
        }*/
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
        game.newGame()
    }
    
    func getThemeName() -> String {
        game.themes[0].name
    }
    
    func getScore() -> Int {
        game.score
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        game.choose(card)
    }
}
