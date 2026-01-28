//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by นายนัชชานนท์ โปษยาอนุวัตร์ on 21/1/2569 BE.
//

import SwiftUI

typealias Peg = Color

//let emoji String = "🥵"

struct CodeBreaker {
    var masterCode: Code = Code(kind: .master)
    var guess: Code = Code(kind: .guess, pegs: [Code.missing, Code.missing, Code.missing, Code.missing])
    var attempts: [Code] = []
    
    let pegChoices: [Peg] = [.red, .green, .yellow, .blue, .brown]
    
    init() {
        masterCode.randomize(from: pegChoices)
        print(masterCode.pegs)
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
        attempt.kind = .attempt(guess.match(against: masterCode))
        attempts.append(attempt)
        guess.reset()
        
    }
    
    mutating func setGuessPeg(_ peg: Peg, at index: Int) {
        guess.pegs[index] = peg
    }
}


