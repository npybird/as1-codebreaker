//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by นายนัชชานนท์ โปษยาอนุวัตร์ on 14/1/2569 BE.
//

import SwiftUI

struct CodeBreakerView: View {
    // MARK: Data Owned by Me
    @State private var game: CodeBreaker = CodeBreaker()
    @State private var selection: Int = 0
    
    // MARK: - body
    var body: some View {
        VStack {
            if game.isOver {
                view(for: game.masterCode)
            }
//            view(for: game.masterCode)
//                .opacity(game.isOver ? 1 : 0)
            if !game.isOver {
                view(for: game.guess)
            }
            ScrollView {
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
            }
            PegChooserView(choices: game.pegChoices) { peg in
                game.setGuessPeg(peg, at: selection)
                selection = (selection + 1) % game.guess.pegs.count
            }
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
    
    struct GuessButton {
        static let maximumFontSize: CGFloat = 80
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
    
