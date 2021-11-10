//
//  LevelPreview.swift
//  PizzaBird
//
//  Created by Olof Hammar on 2021-11-05.
//

import SwiftUI

struct LevelPreview: View {
    
    @EnvironmentObject var game: Game
    @Binding var isGameViewShowing: Bool
    @Binding var isPreviewShowing: Bool
    
    var body: some View {
        ZStack {
            Image("window-card-tall")
                .resizable()
                .frame(width: UIScreen.main.bounds.width/1.5,
                    height: UIScreen.main.bounds.height/2,
                    alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 2)
                        )
            
            Image("btn-level-close")
                .resizable()
                .frame(width: 50, height: 50, alignment: .trailing)
                .padding(.bottom, UIScreen.main.bounds.height/2-35)
                .padding(.leading, UIScreen.main.bounds.width/2+30)
                .onTapGesture {
                    withAnimation {
                        isPreviewShowing.toggle()
                    }
                    playSound(sound: "button-push", type: "mp3", repeatNr: 0, volume: 0.5)
                }
            
            VStack {
                Text("Level \(game.gamePlay.levelNr+1)")
                    .font(.custom("Luckiest Guy", size: 40, relativeTo: .body))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0) {
                    Image("star-medium-on")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width/15, height: UIScreen.main.bounds.width/15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Image("star-medium-on")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width/15, height: UIScreen.main.bounds.width/15, alignment: .center)
                    Image("star-medium-on")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width/15, height: UIScreen.main.bounds.width/15, alignment: .center)
                    
                    Spacer()
                    
                    Text("\(game.gamePlay.levels.levels[game.gamePlay.levelNr].threeStars) Grams")
                        .font(.custom("Luckiest Guy", size: 20, relativeTo: .body))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 0.5)
                        .shadow(color: .black, radius: 0.5)
                        .shadow(color: .black, radius: 0.5)
                        .shadow(color: .black, radius: 0.5)
                        .shadow(color: .black, radius: 0.5)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                }
                .frame(width: UIScreen.main.bounds.width/2, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0) {
                    Image("star-medium-on")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width/15, height: UIScreen.main.bounds.width/15, alignment: .center)
                    Image("star-medium-on")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width/15, height: UIScreen.main.bounds.width/15, alignment: .center)
                   
                    Spacer()
                    
                    Text("\(game.gamePlay.levels.levels[game.gamePlay.levelNr].twoStars) Grams")
                        .font(.custom("Luckiest Guy", size: 20, relativeTo: .body))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 0.5)
                        .shadow(color: .black, radius: 0.5)
                        .shadow(color: .black, radius: 0.5)
                        .shadow(color: .black, radius: 0.5)
                        .shadow(color: .black, radius: 0.5)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                }
                .frame(width: UIScreen.main.bounds.width/2, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0) {
                    Image("star-medium-on")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width/15, height: UIScreen.main.bounds.width/15, alignment: .center)
                   
                    Spacer()
                    
                    Text("\(game.gamePlay.levels.levels[game.gamePlay.levelNr].oneStar) Grams")
                        .font(.custom("Luckiest Guy", size: 20, relativeTo: .body))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 0.5)
                        .shadow(color: .black, radius: 0.5)
                        .shadow(color: .black, radius: 0.5)
                        .shadow(color: .black, radius: 0.5)
                        .shadow(color: .black, radius: 0.5)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                }
                .frame(width: UIScreen.main.bounds.width/2, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                HStack {
                    
                }
                Image("btn-play")
                    .padding(.top, 20)
                    .onTapGesture {
                        withAnimation {
                            isGameViewShowing.toggle()
                        }
                        
                        isPreviewShowing.toggle()
                        playSound(sound: "button-push", type: "mp3", repeatNr: 0, volume: 0.5)
                    }
                    
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color.black.opacity(0.4))
        .ignoresSafeArea(.all)
    }
}

struct LevelPreview_Previews: PreviewProvider {
    static var previews: some View {
        LevelPreview(isGameViewShowing: .constant(false), isPreviewShowing: .constant(true)).environmentObject(Game())
    }
}
