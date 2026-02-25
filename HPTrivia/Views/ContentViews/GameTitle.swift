//
//  GameTitle.swift
//  HPTrivia
//
//  Created by ceboi on 25/02/26.
//

import SwiftUI

struct GameTitle: View {
    @Binding var animateViewIn: Bool
    var body: some View {
        VStack {
            if animateViewIn {
                VStack {
                    Image(systemName: "bolt.fill")
                        .imageScale(.large)
                        .font(.largeTitle)
                    
                    Text("HP")
                        .font(.custom("PartyLetPlain", size: 70 ))
                        .padding(.bottom, -50 )
                    
                    Text("Trivia")
                        .font(.custom("PartyLetPlain", size: 60))
                }
                .padding(.top, 70)
                .transition(.move(edge: .top))
            }
        }
        .animation(.easeOut(duration: 0.7).delay(2), value: animateViewIn)
    }
}

#Preview {
    GameTitle(animateViewIn: .constant(true))
}
