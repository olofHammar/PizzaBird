//
//  GameView.swift
//  PizzaBird
//
//  Created by Olof Hammar on 2021-11-02.
//

import SwiftUI
import SpriteKit
import AVFoundation

struct GameView: View {
    
    @EnvironmentObject var game: Game
    @Binding var isGameViewShowing: Bool
    @State var isNextLevelSelected = false
    @State private var completionFinished = false
    @State var currentLevelStars = 0
    
    var scene: SKScene {
        if (game.gamePlay.levelNr < 6) {
            let scene = GameSceneChapterOne(score: $game.gamePlay.currentLevelWeight, isLevelCompleted: $game.gamePlay.isSelectedLevelCompleted, isRetrySelected: $game.gamePlay.isRetrySelected, isGameViewshowing: $isGameViewShowing, level: $game.gamePlay.levelNr, lives: $game.gamePlay.hearts)
            scene.size = CGSize(width: UIScreen.main.bounds.width,
                                height: UIScreen.main.bounds.height)
            scene.scaleMode = .fill
            
            return scene
        } else {
            let scene = GameSceneChapterTwo(score: $game.gamePlay.currentLevelWeight, isLevelCompleted: $game.gamePlay.isSelectedLevelCompleted, isRetrySelected: $game.gamePlay.isRetrySelected, isGameViewshowing: $isGameViewShowing, level: $game.gamePlay.levelNr, lives: $game.gamePlay.hearts)
            scene.size = CGSize(width: UIScreen.main.bounds.width,
                                height: UIScreen.main.bounds.height)
            scene.scaleMode = .fill
            
            return scene
        }
    }
    
    var body: some View {
        ZStack {
            if (game.gamePlay.levelNr < 4) {
                BackgroundView()
            } else {
                SpaceView()
            }
            
            if (!game.gamePlay.isSelectedLevelCompleted) {
                SpriteView(scene: scene, options: [.allowsTransparency])
            }
            
            if (game.gamePlay.isSelectedLevelCompleted) {
                
                if (game.gamePlay.levelNr == 5) {
                    ChapterCompleted(isGameViewShowing: $isGameViewShowing,
                                     isNextLevelSelected: $isNextLevelSelected,
                                     stars: $currentLevelStars)
                        .onAppear{
                            setLevelCompleted()
                        }
                        .onDisappear{
                            game.gamePlay.isSelectedLevelCompleted = false
                        }
                } else {
                    LevelCompleted(isGameViewShowing: $isGameViewShowing,
                                   isNextLevelSelected: $isNextLevelSelected,
                                   stars: $currentLevelStars)
                        .onAppear{
                            setLevelCompleted()
                        }
                        .onDisappear{
                            game.gamePlay.isSelectedLevelCompleted = false
                        }
                }
            }
        }
        .ignoresSafeArea(.all)
    }
    
    private func setLevelCompleted() {
        
        if (game.gamePlay.currentLevelWeight > game.gamePlay.levels.levels[game.gamePlay.levelNr].score) {
            let weight = game.gamePlay.currentLevelWeight - game.gamePlay.levels.levels[game.gamePlay.levelNr].score
            
            game.gamePlay.totalWeight = game.gamePlay.totalWeight + weight
            game.gamePlay.levels.levels[game.gamePlay.levelNr].score = weight
            
        }
        
        if (game.gamePlay.currentLevelWeight == game.gamePlay.levels.levels[game.gamePlay.levelNr].threeStars) {
            currentLevelStars = 3
            
            if (game.gamePlay.levels.levels[game.gamePlay.levelNr].levelStars < currentLevelStars) {
                game.gamePlay.levels.levels[game.gamePlay.levelNr].levelStars = 3
            }
            
        } else if (game.gamePlay.currentLevelWeight > game.gamePlay.levels.levels[game.gamePlay.levelNr].oneStar) {
            currentLevelStars = 2
            
            if (game.gamePlay.levels.levels[game.gamePlay.levelNr].levelStars < currentLevelStars) {
                game.gamePlay.levels.levels[game.gamePlay.levelNr].levelStars = 2
            }
        } else {
            currentLevelStars = 1
            
            if(game.gamePlay.levels.levels[game.gamePlay.levelNr].levelStars > currentLevelStars) {
                print("Not setting new stars")
            } else {
                game.gamePlay.levels.levels[game.gamePlay.levelNr].levelStars = 1
            }
        }
        
        game.gamePlay.levels.levels[game.gamePlay.levelNr+1].levelUnlocked = true
    }
}

/*
 struct GameView_Previews: PreviewProvider {
 static var previews: some View {
 GameView(isGameViewShowing: .constant(true)).environmentObject(Game())
 }
 }
 */
