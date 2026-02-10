//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by นายนัชชานนท์ โปษยาอนุวัตร์ on 14/1/2569 BE.
//

import SwiftUI

struct CodeBreakerView: View {
    // MARK: Data Owned by Me
    @State private var selectedSet: EmojiSet = .animals
    @State private var game: CodeBreaker = CodeBreaker(emojiSet: .animals)
    @State private var selection: Int = 0
    
    // MARK: - body
    var body: some View {
        VStack {
            if game.isOver {
                view(for: game.masterCode)
            }
            
            if !game.isOver {
                view(for: game.guess)
            }
            
            resetButton
            
            ScrollView {
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
            }
            
            PegChooserView(choices: game.pegChoices) { peg in
                game.setGuessPeg(peg, at: selection)
                selection = (selection + 1) % game.guess.pegs.count
            }
            
            Picker("Emoji Set", selection: $selectedSet) {
                ForEach(EmojiSet.allCases) { set in
                    Text(set.name).tag(set)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: selectedSet, perform: {
                newSet in game = CodeBreaker(emojiSet: newSet);
                selection = 0
            })

        }
        .padding()
    }
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                selection = 0
                game.attemptGuess()
            }
        }
        .font(.system(size: GuessButton.maximumFontSize))
        .minimumScaleFactor(GuessButton.scaleFactor)
    }
    
    var resetButton: some View {
        Button("Reset") {
            withAnimation {
                selection = 0
                game = CodeBreaker(emojiSet: selectedSet)
            }
        }
        .font(.system(size: ResetButton.maximumFontSize))
        .minimumScaleFactor(ResetButton.scaleFactor)
    }
    
    struct GuessButton {
        static let maximumFontSize: CGFloat = 80
        static let minimumFontSize: CGFloat = 8
        static let scaleFactor = minimumFontSize / maximumFontSize
    }
    
    struct ResetButton {
        static let maximumFontSize: CGFloat = 23
        static let minimumFontSize: CGFloat = 8
        static let scaleFactor = minimumFontSize / maximumFontSize
    }
    
    func view(for code: Code) -> some View {
        return HStack {
            // &selection เพราะใน CodeView ใช้เป็น Binding
            CodeView(code: code, selection: $selection)
            
            MatchMarkers(matches: code.matches)
                .overlay {
                    if code.kind == .guess {
                        guessButton
                    }
                }
        }
    }
}


#Preview {
    CodeBreakerView()
        .padding()
}
    
