//
//  ChapterTwoView.swift
//  PizzaBird
//
//  Created by Olof Hammar on 2021-11-06.
//

import SwiftUI

struct ChapterTwoView: View {
    
    @EnvironmentObject var game: Game
    //@Binding var isGameViewShowing : Bool
    @Binding var isPreviewShowing: Bool
    
    var body: some View {
        ZStack {
            Image("chapter-background")
                .resizable()
                .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height/3, alignment: .center)
            VStack {
                Text("Chapter Two")
                    .font(.custom("Luckiest Guy", size: 24, relativeTo: .body))
                    .foregroundColor(.white)
                    .padding(.top, 8)
                
                if (game.gamePlay.totalWeight > 800) {
                                
                    HStack {
                        LevelBtnView(isPreviewShowing: $isPreviewShowing,
                                     levelNr: game.gamePlay.levels.levels[0].levelNr)
                        
                        LevelBtnView(isPreviewShowing: $isPreviewShowing,
                                    levelNr: game.gamePlay.levels.levels[1].levelNr)
                        
                        LevelBtnView(isPreviewShowing: $isPreviewShowing,
                                     levelNr: game.gamePlay.levels.levels[2].levelNr)
                    }
                    .padding(.top)
                    
                    HStack {
                        LevelBtnView(isPreviewShowing: $isPreviewShowing,
                                     levelNr: game.gamePlay.levels.levels[3].levelNr)
                        
                        LevelBtnView(isPreviewShowing: $isPreviewShowing,
                                     levelNr: game.gamePlay.levels.levels[4].levelNr)
                        
                        LevelBtnView(isPreviewShowing: $isPreviewShowing,
                                     levelNr: game.gamePlay.levels.levels[5].levelNr)
                    }
                    .padding(.bottom)
                    
                    Spacer()
                } else {
                    Spacer()
                    
                    Text("Gain 800 grams \n to unlock  \n this chapter.")
                        .font(.custom("Luckiest Guy", size: 30, relativeTo: .body))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 1)
                        .shadow(color: .black, radius: 1)
                        .shadow(color: .black, radius: 1)
                        .shadow(color: .black, radius: 1)
                        .shadow(color: .black, radius: 1)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height/3, alignment: .center)
    }
}

struct ChapterTwoView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterTwoView(isPreviewShowing: .constant(false))
    }
}
