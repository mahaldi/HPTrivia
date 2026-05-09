//
//  Gameplay.swift
//  HPTrivia
//
//  Created by ceboi on 09/03/26.
//

import SwiftUI
import AVKit

struct Gameplay: View {
    @Environment(Game.self) private var game
    @Environment(\.dismiss) private var dismiss
    
    @State private var musicPlayer: AVAudioPlayer!
    @State private var sfxPlayer: AVAudioPlayer!
    
    @State private var animateViewsIn = false
    @State private var revealHint = false
    @State private var revealBook = false
    
    private var backgroundView: some View {
        GeometryReader { geo in
            Image(.hogwarts)
                .resizable()
                .frame(width: geo.size.width * 3.0, height: geo.size.height * 1.05)
                .overlay(
                    Rectangle().foregroundStyle(Color.black.opacity(0.8))
                )
        }
    }

    private var questionText: some View {
        Text(game.currentQuestion.question)
            .font(.custom("PartyLetPlain", size: 50))
            .multilineTextAlignment(.center)
            .padding()
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(.hogwarts)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width * 3.0, height: geo.size.height * 1.05)
                    .overlay(Rectangle().fill(Color.black.opacity(0.8)))
                    .clipped()
                VStack {
                    // MARK: Controls
                    HStack {
                        Button("End Game") {
                            game.endGame()
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red.opacity(0.5))
                        
                        Spacer()
                        
                        Text("Score: \(game.gameScore)")
                    }
                    .padding()
                    .padding(.vertical, 30)
                    
                    // MARK: Question
                    VStack {
                        if animateViewsIn {
                            questionText
                                .transition(.scale)
                        }
                    }
                    .animation(.easeInOut(duration: 2), value: animateViewsIn)
                    Spacer()
                    
                    // MARK: Hints
                    HStack {
                        VStack {
                            if animateViewsIn {
                                let baseIcon = Image(systemName: "questionmark.app.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .foregroundStyle(Color.cyan)
                                    .padding()
                                    .transition(.offset(x: -geo.size.width / 2))
                                    .phaseAnimator([false, true as Bool]) { content, phase in
                                        content.rotationEffect(.degrees(phase ? -13 : -17))
                                    } animation: { _ in
                                            .easeInOut(duration: 0.7)
                                    }

                                baseIcon
                                    .onTapGesture {
                                        withAnimation(.easeOut(duration: 1)) {
                                            revealHint = true
                                        }
                                        playFlipSound()
                                        game.questionScore -= 1
                                    }
                                    .rotation3DEffect(.degrees(revealHint ? 1400 : 0), axis: (x: 0, y: 1, z: 0))
                                    .scaleEffect(revealHint ? 5 : 1)
                                    .offset(x: revealHint ? geo.size.width / 2 : 0)
                                    .opacity(revealHint ? 0 : 1)
                                    .overlay(
                                        Text(game.currentQuestion.hint)
                                            .padding(.leading, 20)
                                            .minimumScaleFactor(0.5)
                                            .multilineTextAlignment(.center)
                                            .opacity(revealHint ? 1 : 0)
                                            .scaleEffect(revealHint ? 1.33 : 1)
                                    )
                                    .transition(.offset(x: -geo.size.width / 2))
                            }
                            
                        }
                        .animation(.easeOut(duration: 1.5).delay(2), value: animateViewsIn)
                        Spacer()
                        VStack {
                            if animateViewsIn {
                                let baseIcon2 = Image(systemName: "app.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .foregroundStyle(Color.cyan)
                                    .overlay {
                                        Image(systemName: "book.closed")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50)
                                            .foregroundStyle(.black)
                                    }
                                    .padding()
                                    .transition(.offset(x: geo.size.width / 2))
                                    // animasi terlihat "bergoyang" atau "berdenyut" dengan rotasi yang bergantian antara 13° dan 17°, menciptakan efek visual yang menarik perhatian pengguna untuk mengklik hint tersebut.
                                    .phaseAnimator([false, true as Bool]) { content, phase in
                                        content.rotationEffect(.degrees(phase ? 13 : 17))
                                    } animation: { _ in
                                            .easeInOut(duration: 0.7)
                                    }

                                baseIcon2
                                    .onTapGesture {
                                        withAnimation(.easeOut(duration: 1)) {
                                            revealBook = true
                                        }
                                        playFlipSound()
                                        game.questionScore -= 1
                                    }
                                    .rotation3DEffect(.degrees(revealBook ? -1400 : 0), axis: (x: 0, y: 1, z: 0))
                                    .scaleEffect(revealBook ? 5 : 1)
                                    .offset(x: revealBook ? -geo.size.width / 2 : 0)
                                    .opacity(revealBook ? 0 : 1 )
                                    .overlay(
                                        Image("hp\(game.currentQuestion.book)")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(.trailing, 20)
                                            .opacity(revealBook ? 1 : 0)
                                            .scaleEffect(revealBook ? 1.33 : 1)
                                    )
                                    .transition(.offset(x: geo.size.width / 2))
                            }
                            
                        }
                        .animation(.easeOut(duration: 1.5).delay(2), value: animateViewsIn)
                    }
                    .padding()
                    
                    // MARK: Answers
                    Spacer()
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .foregroundStyle(.white)
                
                // MARK: Celebration screen
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear {
            game.startGame()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                animateViewsIn = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                playMusic()
            }
        }
    }
    
    private func playMusic() {
        let songs = ["let-the-mystery-unfold", "spellcraft", "hiding-place-in-the-forest", "deep-in-the-dell"]
        let song = songs.randomElement()
        let sound = Bundle.main.path(forResource: song, ofType: "mp3")
        musicPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        musicPlayer.numberOfLoops = -1 // infinity
        musicPlayer.volume = 0.1
//        musicPlayer.play()
    }
    
    private func playFlipSound() {
        let sound = Bundle.main.path(forResource: "page-flip", ofType: "mp3")
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        sfxPlayer.play()
    }
    
    private func playWrongSound() {
        let sound = Bundle.main.path(forResource: "negative-beeps", ofType: "mp3")
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        sfxPlayer.play()
    }
    
    private func playCorrectSound() {
        let sound = Bundle.main.path(forResource: "magic-wand", ofType: "mp3")
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        sfxPlayer.play()
    }
}

#Preview {
    Gameplay()
        .environment(Game())
}
