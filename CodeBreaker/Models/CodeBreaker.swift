//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by นายนัชชานนท์ โปษยาอนุวัตร์ on 21/1/2569 BE.
//

//import SwiftUI

typealias Peg = String

//let emoji String = "🥵"

struct CodeBreaker {
    var masterCode: Code
    var guess: Code
    var attempts: [Code] = []

    let emojiSet: EmojiSet
    let pegCount: Int

//    let pegChoices: [Peg] = [.red, .green, .yellow, .blue, .brown, .purple]
    var pegChoices: [Peg] {
        emojiSet.pegs
    }
    
    init(pegCount: Int, emojiSet: EmojiSet) {
        self.pegCount = pegCount
        self.emojiSet = emojiSet
        
        self.masterCode = Code(kind: .master, pegCount: pegCount)
        self.guess = Code(kind: .guess, pegCount: pegCount)

        masterCode.randomize(from: pegChoices)
        print(masterCode.pegs)
    }

    init(emojiSet: EmojiSet) {
        let random = Int.random(in: 3...6)
        self.init(pegCount: random, emojiSet: emojiSet)
    }
    
    var isOver: Bool {
        // ?. คือ ถ้า Array ไม่ใช่ nil จะ unwrapped ให้เอง
        attempts.last?.pegs == masterCode.pegs
    }
    
    mutating func changeGuessPeg(at index: Int) {
        let existingPeg = guess.pegs[index]
        
        if let indexOfExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg) {
            guess.pegs[index] = pegChoices[(indexOfExistingPegInPegChoices + 1) % pegChoices.count]
        } else {
            guess.pegs[index] = pegChoices.first ?? Code.missing
        }
    }
    
    mutating func attemptGuess() {
        var attempt = guess
        if attempts.contains(where: { $0.pegs == attempt.pegs }) || attempt.pegs.contains(Code.missing) {
            return
        } else {
            attempt.kind = .attempt(guess.match(against: masterCode))
            attempts.append(attempt)
            guess.reset()
        }
    }
    
    mutating func resetGame() {
        attempts.removeAll()
        guess.reset()
        masterCode.randomize(from: pegChoices)
        print(masterCode.pegs)
    }
    
    mutating func setGuessPeg(_ peg: Peg, at index: Int) {
        guess.pegs[index] = peg
    }
}

enum EmojiSet: String, CaseIterable, Identifiable {
    case animals
    case faces
    case food

    var id: String { rawValue }

    var name: String {
        switch self {
        case .animals: return "Animals 🐶"
        case .faces: return "Faces 😀"
        case .food: return "Food 🍎"
        }
    }

    var pegs: [String] {
        switch self {
        case .animals:
            return ["🐶","🐱","🐼","🦊","🐸","🐵"]
        case .faces:
            return ["😀","😂","🥹","😡","😴","😎"]
        case .food:
            return ["🍎","🍌","🍇","🍔","🍕","🍩"]
        }
    }
}

