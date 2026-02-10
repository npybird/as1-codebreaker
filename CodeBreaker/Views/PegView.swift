//
//  PegView.swift
//  CodeBreaker
//
//  Created by นายนัชชานนท์ โปษยาอนุวัตร์ on 28/1/2569 BE.
//

import SwiftUI

struct PegView: View {
    // MARK: Data In
    let peg: Peg
    
//    let size: CGFloat = 40
    
    // MARK: - body
    var body: some View {
//        let pegShape = Circle() // RoundedRectangle(cornerRadius: 10)
        ZStack {
            Circle()
                .stroke(peg == Code.missing ? Color.gray : .clear)
            
            Text(peg)
                .aspectRatio(1, contentMode: .fit)
                .font(.system(size: 120))
                .minimumScaleFactor(9/120)
                .overlay {
                    if peg == Code.missing {
                        Circle()
                            .stroke(Color.gray)
                    }
                    
                    Circle()
                        .stroke(.clear)
                }
        }
//        .frame(width: size, height: size)
    }
}

#Preview {
    PegView(peg: "😀")
        .padding()
}
