//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Daniel Kim on 2024-01-03.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
