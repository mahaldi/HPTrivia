//
//  PlayButton.swift
//  HPTrivia
//
//  Created by ceboi on 25/02/26.
//

import SwiftUI

struct PlayButton: View {
    
    @Binding var animateViewIn: Bool
    @State var playGame = false
    @State private var scalePlayBtn = false
    let geo: GeometryProxy
    var body: some View {
        VStack {
            if animateViewIn {
                Button {
                    playGame.toggle()
                } label: {
                    Text("Play ")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 50)
                        .background(.brown)
                        .clipShape(.rect(cornerRadius: 7))
                        .shadow(radius: 5)
                        .scaleEffect(scalePlayBtn ? 1.2 : 1)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.3).repeatForever()) {
                                scalePlayBtn = true
                            }
                        }
                }
                .transition(.offset(y: geo.size.height / 3))
            }
        }
        .animation(.easeOut(duration: 0.7).delay(2), value: animateViewIn)
    }
}

#Preview {
    GeometryReader { geo in
        PlayButton(animateViewIn: .constant(true as Bool), geo: geo)
    }
}
