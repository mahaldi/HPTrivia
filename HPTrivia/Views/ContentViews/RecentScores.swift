//
//  RecentScores.swift
//  HPTrivia
//
//  Created by ceboi on 25/02/26.
//

import SwiftUI

struct RecentScores: View {
    @Binding var animateViewIn: Bool
    var body: some View {
        VStack {
            if animateViewIn {
                VStack {
                    Text("Recent Scores")
                        .font(.title2)
                    
                    Text("33")
                }
                .font(.title3)
                .foregroundStyle(.white)
                .padding(.horizontal)
                .background(.black.opacity(0.7))
                .clipShape(.rect(cornerRadius: 15))
                .transition(.opacity)
            }
        }
        .animation(.linear(duration: 1).delay(4), value: animateViewIn)
    }
}

#Preview {
    RecentScores(animateViewIn: .constant(true))
}
