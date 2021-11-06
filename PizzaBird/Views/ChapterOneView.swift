import SwiftUI

struct ChapterOneView: View {
    
    @EnvironmentObject var game: Game
    //@Binding var isGameViewShowing : Bool
    @Binding var isPreviewShowing: Bool
    
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
            }
        }
        .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height/3, alignment: .center)
    }
}


struct ChapterOneView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterOneView(isPreviewShowing: .constant(false))
    }
}
