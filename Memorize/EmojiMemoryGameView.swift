//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Daniel Kim on 2024-01-02.
//

import SwiftUI

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
    
    
    var body: some View {
        VStack{
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Spacer()
            HStack{
                newGameButton
                Spacer()
                Button("Shuffle") {
                    viewModel.shuffle()
                }
            }
            
        }
        .padding()
    }
    
    var newGameButton: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            Text("New Game")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        })
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60), spacing: 0)]) {
            
            ForEach(viewModel.cards) { card in CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
            
        }.foregroundColor(.orange)
    }

}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View{
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }.opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
        
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
