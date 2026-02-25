//
//  ContentView.swift
//  HPTrivia
//
//  Created by ceboi on 28/01/26.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer!
    @State private var animateViewIn = false
    @State private var scalePlayBtn = false
    @State private var showSettings = false
    @State private var playGame = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                AnimatedBackground(geo: geo)
                VStack {
                    GameTitle(animateViewIn: $animateViewIn)
                    Spacer()
                    RecentScores(animateViewIn: $animateViewIn)
                    Spacer()
                    ButtonBar(geo: geo, animateViewIn: $animateViewIn)
                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            
        }
        .ignoresSafeArea()
        .onAppear {
            animateViewIn = true
            //            playAudio()
        }
    }
    
    private func playAudio() {
        let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        audioPlayer.numberOfLoops = -1 // infinity
        audioPlayer.play()
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
