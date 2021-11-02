import SwiftUI

struct ChapterOneView: View {
    
    @EnvironmentObject var game: Game
    @Binding var isGameViewShowing : Bool
    
    var body: some View {
        ZStack {
            Image("chapter-background")
                .resizable()
                .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height/3, alignment: .center)
            VStack {
                Text("Chapter One")
                    .font(.custom("Luckiest Guy", size: 24, relativeTo: .body))
                    .foregroundColor(.white)
                    .padding(.top, 8)
                                
                HStack {
                    LevelBtnView(isGameViewShowing: $isGameViewShowing, level: GameSceneChapterOne(score: $game.gamePlay.currentLevelWeight, isLevelCompleted: $game.gamePlay.levels.levels[1].levelCompleted, isRetrySelected: $game.gamePlay.isRetrySelected, isGameViewshowing: $isGameViewShowing, level: $game.gamePlay.levels.levels[1].levelNr),
                                 levelNr: game.gamePlay.levels.levels[1].levelNr)
                    
                    LevelBtnView(isGameViewShowing: $isGameViewShowing, level: GameSceneChapterOne(score: $game.gamePlay.currentLevelWeight, isLevelCompleted: $game.gamePlay.levels.levels[2].levelCompleted, isRetrySelected: $game.gamePlay.isRetrySelected, isGameViewshowing: $isGameViewShowing, level: $game.gamePlay.levels.levels[2].levelNr), levelNr: game.gamePlay.levels.levels[2].levelNr)
                    
                    LevelBtnView(isGameViewShowing: $isGameViewShowing, level: GameSceneChapterOne(score: $game.gamePlay.currentLevelWeight, isLevelCompleted: $game.gamePlay.levels.levels[3].levelCompleted, isRetrySelected: $game.gamePlay.isRetrySelected, isGameViewshowing: $isGameViewShowing, level: $game.gamePlay.levels.levels[3].levelNr), levelNr: game.gamePlay.levels.levels[3].levelNr)
                }
                .padding(.top)
                
                HStack {
                    LevelBtnView(isGameViewShowing: $isGameViewShowing, level: GameSceneChapterOne(score: $game.gamePlay.currentLevelWeight, isLevelCompleted: $game.gamePlay.levels.levels[4].levelCompleted, isRetrySelected: $game.gamePlay.isRetrySelected, isGameViewshowing: $isGameViewShowing, level: $game.gamePlay.levels.levels[4].levelNr), levelNr: game.gamePlay.levels.levels[4].levelNr)
                    
                    LevelBtnView(isGameViewShowing: $isGameViewShowing, level: GameSceneChapterOne(score: $game.gamePlay.currentLevelWeight, isLevelCompleted: $game.gamePlay.levels.levels[5].levelCompleted, isRetrySelected: $game.gamePlay.isRetrySelected, isGameViewshowing: $isGameViewShowing, level: $game.gamePlay.levels.levels[5].levelNr), levelNr: game.gamePlay.levels.levels[5].levelNr)
                    
                    LevelBtnView(isGameViewShowing: $isGameViewShowing, level: GameSceneChapterOne(score: $game.gamePlay.currentLevelWeight, isLevelCompleted: $game.gamePlay.levels.levels[6].levelCompleted, isRetrySelected: $game.gamePlay.isRetrySelected, isGameViewshowing: $isGameViewShowing, level: $game.gamePlay.levels.levels[6].levelNr), levelNr: game.gamePlay.levels.levels[6].levelNr)
                }
                .padding(.bottom)
                
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height/3, alignment: .center)
    }
    
}


struct ChapterOneView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterOneView(isGameViewShowing: .constant(false))
    }
}
