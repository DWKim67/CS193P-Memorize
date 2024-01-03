//
//  ContentView.swift
//  Memorize
//
//  Created by Daniel Kim on 2024-01-02.
//

import SwiftUI

enum Theme {
    case halloween, christmas, beach
}

struct ContentView: View {
    let halloweenEmojis: Array<String> = ["👻","🎃","🕷️","😈","💀","🕸️","🧙"]
    let xmasEmojis: Array<String> = ["🎅","🦌","🎄","🎁","⛄️","❄️"]
    let beachEmojis: Array<String> = ["🌊","☀️","🐚","🏖️","🦀","🩴"]
    
    @State var currentTheme = Theme.halloween
    @State var cardCount: Int = 7 * 2
    @State var emojis = ["👻","🎃","🕷️","😈","💀","🕸️"]
    @State var didButtonActivate = false
    
    
    var body: some View {
        VStack{
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            ScrollView {
                cards
            }
            
            Spacer()
            themeChoosers
        }
        
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
            
        }.foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }.imageScale(.large)
            .font(.largeTitle)
    }
    
    var themeChoosers: some View {
        HStack(alignment:.bottom, spacing: 30) {
            spookyThemeChooser
            xmasThemeChooser
            beachThemeChooser
        }
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
                cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    func themeChooser(symbol: String, theme: Theme, title: String) -> some View {
        Button(action: {
            currentTheme = theme
            updateEmojiTheme()
        }, label: {
            VStack{
                Image(systemName: symbol)
                    .imageScale(.large)
                        .font(.title)
                Text(title)
            }
            
        })
    }
    
    func updateEmojiTheme() {
        switch currentTheme {
        case .beach:
            emojis = beachEmojis
        case .christmas:
            emojis = xmasEmojis
        default:
            emojis = halloweenEmojis
        }
    }
    
    var spookyThemeChooser: some View {
        themeChooser(symbol: "questionmark.circle", theme: Theme.halloween, title: "Spooky")
    }
    
    var beachThemeChooser: some View {
        themeChooser(symbol: "figure.volleyball", theme: Theme.beach, title: "Beach")
    }
    
    var xmasThemeChooser: some View {
        themeChooser(symbol: "app.gift", theme: Theme.christmas, title: "XMas")
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.fill.badge.plus")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View{
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
