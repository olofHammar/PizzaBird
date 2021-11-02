//
//  GameView.swift
//  PizzaBird
//
//  Created by Olof Hammar on 2021-11-02.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    
    @EnvironmentObject var game: Game
    @Binding var isGameViewShowing: Bool
    
    var scene: SKScene {
        let scene = GameSceneChapterOne(score: $game.gamePlay.currentLevelWeight, isLevelCompleted: $game.gamePlay.isSelectedLevelCompleted, isRetrySelected: $game.gamePlay.isRetrySelected, isGameViewshowing: $isGameViewShowing, level: $game.gamePlay.levelNr)
        scene.size = CGSize(width: UIScreen.main.bounds.width,
                            height: UIScreen.main.bounds.height)
        scene.scaleMode = .fill
        
            return scene
        }
    
    var body: some View {
        ZStack {
            BackgroundView()
            SpriteView(scene: scene, options: [.allowsTransparency])
            
                
                
        }
        .ignoresSafeArea(.all)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(isGameViewShowing: .constant(true)).environmentObject(Game())
    }
}
