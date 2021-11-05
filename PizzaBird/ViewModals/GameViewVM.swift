//
//  GameViewVM.swift
//  PizzaBird
//
//  Created by Olof Hammar on 2021-11-03.
//

import Foundation
import SpriteKit

class GameViewVM: ObservableObject {
  
  var game: Game?
  
  func setScene(game: Game) {
    var scene: SKScene {
        let scene = GameSceneChapterOne(score: $game.gamePlay.currentLevelWeight, isLevelCompleted: $game.gamePlay.isSelectedLevelCompleted, isRetrySelected: $game.gamePlay.isRetrySelected, isGameViewshowing: $isGameViewShowing, level: $game.gamePlay.levelNr)
        scene.size = CGSize(width: UIScreen.main.bounds.width,
                            height: UIScreen.main.bounds.height)
        scene.scaleMode = .fill
        
        print(game.gamePlay.levelNr)
        
            return scene
        }
  }
}
