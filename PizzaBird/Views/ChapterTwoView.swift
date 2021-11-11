import SwiftUI

struct ChapterTwoView: View {
    
    @EnvironmentObject var game: Game
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
                
                if (game.gamePlay.totalWeight >= 480) {
                    
                    HStack {
                        LevelBtnView(isPreviewShowing: $isPreviewShowing,
                                     levelNr: game.gamePlay.levels.levels[6].levelNr)
                        
                        LevelBtnView(isPreviewShowing: $isPreviewShowing,
                                     levelNr: game.gamePlay.levels.levels[7].levelNr)
                        
                        LevelBtnView(isPreviewShowing: $isPreviewShowing,
                                     levelNr: game.gamePlay.levels.levels[8].levelNr)
                    }
                    .padding(.top)
                    
                    HStack {
                        LevelBtnView(isPreviewShowing: $isPreviewShowing,
                                     levelNr: game.gamePlay.levels.levels[9].levelNr)
                        
                        LevelBtnView(isPreviewShowing: $isPreviewShowing,
                                     levelNr: game.gamePlay.levels.levels[10].levelNr)
                        
                        LevelBtnView(isPreviewShowing: $isPreviewShowing,
                                     levelNr: game.gamePlay.levels.levels[11].levelNr)
                    }
                    .padding(.bottom)
                    
                    Spacer()
                } else {
                    Spacer()
                    
                    Text("Gain \(480 - game.gamePlay.totalWeight) grams \n to unlock  \n this chapter.")
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
