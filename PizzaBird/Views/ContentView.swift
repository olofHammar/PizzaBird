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

    var body: some View {
        ZStack {
          BackgroundView()
            VStack {
                TopBorder(hearts: $game.gamePlay.hearts, totalWeight: $game.gamePlay.totalWeight)
                
                Spacer()
                
                ChapterOneView(isGameViewShowing: $isGameViewShowing)
                
                Spacer()
                
                ChapterOneView(isGameViewShowing: $isGameViewShowing)
                
                Spacer()
            }
            
            if (isGameViewShowing) {
                GameView(isGameViewShowing: $isGameViewShowing)
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Game())
    }
}
