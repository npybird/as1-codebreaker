//
//  CodeView.swift
//  CodeBreaker
//
//  Created by นายนัชชานนท์ โปษยาอนุวัตร์ on 28/1/2569 BE.
//

import SwiftUI

struct CodeView: View {
    // MARK: Data In
    let code: Code
    
    // MARK: Data Shared by Me
    @Binding var selection: Int
    
    
    // MARK: - body
    var body: some View {
        ForEach(code.pegs.indices, id: \.self) { index in
            PegView(peg: code.pegs[index])
                .padding(Selection.border)
                .background {
                    if selection == index, code.kind == .guess {
                        Circle()
                            .foregroundStyle(Selection.color)
                    }
                }
                .onTapGesture {
                    if code.kind == .guess {
                        selection = index
                        
                    }
                }
        }
    }
    struct Selection {
        static let border: CGFloat = 5
        static let color: Color = .gray(0.85)
    }
}

// เพิ่มคุณสมบัติให้ struct Color
extension Color {
    static func gray(_ brightness: CGFloat) -> Color {
        Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}

//#Preview {
//    CodeView()
//}
