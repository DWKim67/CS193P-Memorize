//
//  CardView.swift
//  Memorize
//
//  Created by Daniel Kim on 2024-01-09.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    

    var body: some View{
        TimelineView(.animation(minimumInterval: 1/20)) { timeline in
            if card.isFaceUp || !card.isMatched {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                        .stroke(lineWidth: 3)
                        .opacity(0.4)
                        .overlay(
                            cardContents
                        )
                        .padding(5)
                        .cardify(isFaceUp: card.isFaceUp)
                        .transition(.scale)
            } else {
                Color.clear
            }
            
        }
        
    }
    
    var cardContents: some View {
        Text(card.content)
            .font(.system(size: 200))
            .minimumScaleFactor(0.01)
            .multilineTextAlignment(.center)
            .aspectRatio(1, contentMode: .fit)
            .padding(5)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: 1), value: card.isMatched)
    }
    
    
    private struct Constants {
        static let cornerRaidus: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest/largest
        }
    }
    
        
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: 1).repeatForever(autoreverses: false)
    }
}


struct CardView_Preivews: PreviewProvider {
    typealias Card = MemoryGame<String>.Card
    
    static var previews: some View {
        VStack {
            HStack{
                CardView(Card(isFaceUp: true, content: "X", id: "test1"))
                    .aspectRatio(4/3, contentMode: .fit)
                CardView(Card( content: "X", id: "test2"))
            }
            HStack{
                CardView(Card(isFaceUp: true, isMatched: true, content: "This is a very long string and I hope it fits", id: "test1"))
                CardView(Card(isMatched: false, content: "X", id: "test2"))
            }
        }
            .padding()
            .foregroundColor(.green)
    }
    
}
