//
//  EmojiMemoryGame.swift
//  Lecture1
//
//  Created by Sunwoo on 2022/07/23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    init() {
        theme = EmojiMemoryGame.themes.randomElement()!
        theme.emojis.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    private static var themes = [
        Theme(name: "Vehicles",
              emojis: ["🚂","🚘", "🛵", "🛸", "🛴", "🚍", "🚛", "🚞", "🚁", "🚔", "🛺", "🚐", "🚒", "🚑" ,"🚜"," 🐸", "🐛", "🦋", "🚖", "🚝", "🚡"],
              pairCards: 10,
              color: "red"),
        Theme(name: "Sports",
              emojis: ["⚽️", "🏀", "🏈", "🥎", "⚾️", "🏓", "🤿", "🥊", "🏹", "🪀", "⛳️", "🎱", "🪃", "🏸", "🏒"],
              pairCards: 8,
              color: "yellow"),
        Theme(name: "Flags",
              emojis: ["🇬🇭", "🇬🇦", "🇬🇾", "🇬🇲", "🇬🇬", "🇬🇺", "🇬🇹", "🇰🇷", "🇳🇪", "🇱🇷", "🇺🇸", "🇧🇩" , "🇲🇾", "🇸🇧", "🏴󠁧󠁢󠁥󠁮󠁧󠁿"],
              pairCards: 6,
              color: "blue"),
        Theme(name: "Plants",
              emojis: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🫐", "🍑", "🥭", "🍍", "🥥", "🥝", "🍅"],
              pairCards: 8,
              color: "green")
    ]
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.pairCards) { pairIndex in
            theme.emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String>
    private var theme: Theme
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var themeName: String {
        return theme.name
    }
    
    var cardColor: Color {
        switch theme.color {
        case "red" :
            return .red
        case "green":
            return .green
        case "yellow":
            return .yellow
        case "blue":
            return .blue
        default:
            return .black
        }
    }
    
    var gamePoint: Int {
        return model.score
    }
    
    //MARK: - Intent(s)
    
    func choose(_ card: Card) {
        //objectWillChange.send()
        model.choose(card)
    }
    
    func newGame() {
        guard let randomEmoji = EmojiMemoryGame.themes.randomElement() else {
            return
        }
        
        theme = randomEmoji
        theme.emojis.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}
