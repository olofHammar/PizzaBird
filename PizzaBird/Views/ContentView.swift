//
//  ContentView.swift
//  PizzaBird
//
//  Created by Olof Hammar on 2021-11-02.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @EnvironmentObject var game: Game
    @State var isGameViewShowing = false
    @State var isPreviewShowing = false
    @State var backgroundMusic: AVAudioPlayer!

    var body: some View {
        ZStack {
          SkyView()
            VStack {
                TopBorder(hearts: $game.gamePlay.hearts, totalWeight: $game.gamePlay.totalWeight)
                
                Spacer()
                
                ChapterOneView(isPreviewShowing: $isPreviewShowing)
                
                Spacer()
                
                ChapterTwoView(isPreviewShowing: $isPreviewShowing)
                
                Spacer()
            }
            
            if (isPreviewShowing) {
                LevelPreview(isGameViewShowing: $isGameViewShowing, isPreviewShowing: $isPreviewShowing)
                    .transition(.opacity)
            }
            
            if (isGameViewShowing) {
                GameView(isGameViewShowing: $isGameViewShowing)
                    .transition(.slide)
                    .onAppear {
                        backgroundMusic.volume = 0.8
                    }
                    .onDisappear {
                        backgroundMusic.volume = 0.4
                    }
                
            }
        }
        .ignoresSafeArea(.all)
        .onAppear{
            game.gamePlay.isSelectedLevelCompleted = false
            playBackgroundMusic()
        }
    }
    
    private func playBackgroundMusic() {
        let sound = Bundle.main.path(forResource: "backgroundMusic", ofType: "mp3")
                    self.backgroundMusic = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        
        backgroundMusic.volume = 0.4
        backgroundMusic.numberOfLoops = -1
        backgroundMusic.play()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Game())
    }
}
