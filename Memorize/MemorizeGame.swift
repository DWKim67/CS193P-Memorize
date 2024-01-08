//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Daniel Kim on 2024-01-03.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var themes: [Theme]
    private(set) var score: Int
    
    init(themePackage: () -> [Theme]) {
        cards = []
        themes = themePackage()
        score = 0
        
        themes.shuffle()
        themes[0].emojis.shuffle()
        // Add numberOfPairsOfCards x 2 cards
        
        for pairIndex in 0..<max(2, themes[0].numPairs) {
            let content = themes[0].emojis[pairIndex]
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        
        cards.shuffle()
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    
    // Handles logic of flipping cards when chosen
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score+=2
                    } else {
                        if cards[chosenIndex].previouslySeen { score-=1 } else {
                            cards[chosenIndex].previouslySeen = true
                        }
                        if cards[potentialMatchIndex].previouslySeen { score-=1 } else {
                            cards[potentialMatchIndex].previouslySeen = true
                        }
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func newGame() {
        themes.shuffle()
        themes[0].emojis.shuffle()
        // Add numberOfPairsOfCards x 2 cards
        
        cards = []
        
        for pairIndex in 0..<max(2, themes[0].numPairs) {
            let content = themes[0].emojis[pairIndex]
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        
        cards.shuffle()
    }
    
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var previouslySeen: Bool = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up": "down")\(isMatched ? " matched" : "")"
        }
    }
    
    struct Theme {
        let name: String
        var emojis: [CardContent]
        var numPairs: Int
        let color: String
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
