//
//  GameViewVM.swift
//  PizzaBird
//
//  Created by Olof Hammar on 2021-11-04.
//

import Foundation

class GameViewVM: ObservableObject {
    
    var gamePlayVM: Game?
      
      
    func setup(_ gamePlayVM: Game) {
        self.gamePlayVM = gamePlayVM
    }
    
    func setLevelCompleted() {

        if (gamePlayVM.gamePlay.currentLevelWeight > gamePlayVM.gamePlay.levels.levels[gamePlayVM.gamePlay.levelNr].score) {
            let weight = gamePlayVM.gamePlay.currentLevelWeight - gamePlayVM.gamePlay.levels.levels[game.gamePlay.levelNr].score
            
            gamePlayVM.gamePlay.totalWeight = gamePlayVM.gamePlay.totalWeight + weight
            gamePlayVM.gamePlay.levels.levels[game.gamePlay.levelNr].score = weight

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
