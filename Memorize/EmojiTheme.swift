//
//  EmojiTheme.swift
//  Memorize
//
//  Created by Daniel Kim on 2024-01-08.
//

import SwiftUI

struct EmojiTheme {
    let name: String
    var emojis: [String]
    var numPairs: Int
    let color: Color
    
    static let builtins = [
        EmojiTheme(name: "Halloween", emojis: ["👻","🎃","🕷️","😈","💀","🧙"], numPairs: 2, color: .orange),
        EmojiTheme(name: "Christmas", emojis: ["🎅","🦌","🎄","🎁","⛄️","❄️"], numPairs: 4, color: .green),
        EmojiTheme(name: "Beach", emojis: ["🌊","☀️","🐚","🏖️","🦀","🩴"], numPairs: 2, color: .blue),
        EmojiTheme(name: "School", emojis: ["📚","🏫","✏️","🚌","🎓","➗"], numPairs: 6, color: .black),
        EmojiTheme(name: "Art", emojis: ["🎨","🧑‍🎨","✏️","✍️","🖌️","🖼️"], numPairs: 6, color: .brown),
        EmojiTheme(name: "Party", emojis: ["🍻","🍿","🪩","🎉","🍾","🤢"], numPairs: 6, color: .yellow)
    ]
}
