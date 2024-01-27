//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Daniel Kim on 2024-01-02.
//

import SwiftUI

typealias Card = MemoryGame<String>.Card

enum Theme {
    case halloween, christmas, beach
}

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    let halloweenEmojis: Array<String> = ["👻","🎃","🕷️","😈","💀","🧙"]
    let xmasEmojis: Array<String> = ["🎅","🦌","🎄","🎁","⛄️","❄️"]
    let beachEmojis: Array<String> = ["🌊","☀️","🐚","🏖️","🦀","🩴"]
    
    @State var currentTheme = Theme.halloween
    @State var cardCount: Int = 7 * 2
    @State var emojis = ["👻","🎃","🕷️","😈","💀","🧙"].shuffled() + ["👻","🎃","🕷️","😈","💀","🧙"].shuffled()
    @State var didButtonActivate = false
    
    private let aspectRatio: CGFloat = 2/3
    private let padding = 4
    
    var body: some View {
        VStack{
            topText
                .animation(nil)
            Spacer()
                .frame(height:20)
                cards
                    //.animation(.default, value: viewModel.cards)
            Spacer()
            deck
                .foregroundColor(viewModel.getThemeColor())
            HStack{
                newGameButton
                Spacer()
                shuffle
            }
            
        }
        .padding()
    }
    
    private var topText: some View {
        VStack {
    
        Text("Memorize!")
            .font(.largeTitle)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        Text("Theme: \(viewModel.getThemeName())")
        Text("Score: \(viewModel.getScore())")
        }

    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation() {
                viewModel.shuffle()
            }
        }
    }
    
    private var newGameButton: some View {
        Button(action: {
            viewModel.newGame()
            dealt.removeAll()
        }, label: {
            Text("New Game")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        })
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .aspectRatio(aspectRatio, contentMode: .fit)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .padding(4)
                    .onTapGesture {
                        choose(card)
                    }
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                }
                    
            }
        
        .foregroundColor(viewModel.getThemeColor())
        }
        
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter {!isDealt($0)}
    }
    
    @Namespace private var dealingNamespace
    
    private var deck: some View {
        ZStack{
            ForEach(undealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
            .frame(width: deckWidth, height: deckWidth / aspectRatio)
            .onTapGesture {
                deal()
                
            }
        }
    }
    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(.easeInOut(duration:1).delay(delay)) {
                    _ = dealt.insert(card.id)
            }
            delay += dealInterval
        }
    }
    
    
    private let dealInterval: TimeInterval = 0.15
    private let deckWidth: CGFloat = 50
    
    private func choose(_ card: Card ) {
        withAnimation(.easeInOut(duration: 0.5)) {
            let scoreBeforeChoosing = viewModel.getScore()
            viewModel.choose(card)
            let scoreChange = viewModel.getScore() - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardID: card.id)
        }
    }
    @State private var lastScoreChange = (0, causedByCardID: "")
    
    private func scoreChange(causedBy card: MemoryGame<String>.Card) -> Int {
        let (amount, causedByCardID: id) = lastScoreChange
        return card.id == id ? amount : 0
    }
}
    
    


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
