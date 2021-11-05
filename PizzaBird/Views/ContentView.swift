//
//  ContentView.swift
//  PizzaBird
//
//  Created by Olof Hammar on 2021-11-02.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var game: Game
    @State var isGameViewShowing = false
    @State var isPreviewShowing = false

    var body: some View {
        ZStack {
          SkyView()
            VStack {
                TopBorder(hearts: $game.gamePlay.hearts, totalWeight: $game.gamePlay.totalWeight)
                
                Spacer()
                
                ChapterOneView(isPreviewShowing: $isPreviewShowing)
                
                Spacer()
                
                ChapterOneView(isPreviewShowing: $isPreviewShowing)
                
                Spacer()
            }
            
            if (isPreviewShowing) {
                LevelPreview(isGameViewShowing: $isGameViewShowing, isPreviewShowing: $isPreviewShowing)
                    .transition(.opacity)
            }
            
            if (isGameViewShowing) {
                GameView(isGameViewShowing: $isGameViewShowing)
                    .transition(.opacity)
            }
        }
        .ignoresSafeArea(.all)
        .onAppear{
            game.gamePlay.isSelectedLevelCompleted = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Game())
    }
}
