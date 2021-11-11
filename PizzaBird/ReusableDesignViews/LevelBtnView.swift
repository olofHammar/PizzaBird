import SwiftUI
import SpriteKit

struct LevelBtnView: View {
    
    @EnvironmentObject var game: Game
    @Binding var isPreviewShowing: Bool
    
    var levelNr: Int
    var levelImage: Image!
    
    var body: some View {
        
        ZStack {
            Image(setImage())
                .resizable()
                .frame(width: UIScreen.main.bounds.width/6, height: UIScreen.main.bounds.height/12, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .onTapGesture {
                    if game.gamePlay.levels.levels[levelNr].levelUnlocked {
                        
                        game.gamePlay.levelNr = levelNr
                        //game.gamePlay.levelName = levelName
                        //isGameViewShowing.toggle()
                        withAnimation {
                            isPreviewShowing.toggle()
                        }
                        playSound(sound: "button-push", type: "mp3", repeatNr: 0, volume: 0.5)
                        print("\(game.gamePlay.totalWeight)")
                    }
                }
            VStack {
                Spacer()
                
                Text(setText())
                    .font(.custom("Luckiest Guy", size: 35, relativeTo: .body))
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.height/8, alignment: .center)
                    .padding(.bottom, 12)
                    .shadow(color: Color(#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)), radius: 1)
                    .shadow(color: Color(#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)), radius: 1)
                    .shadow(color: Color(#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)), radius: 1)
                    .shadow(color: Color(#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)), radius: 1)
                
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width/5, height: UIScreen.main.bounds.height/10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
    
    private func setImage() -> String {
        if game.gamePlay.levels.levels[levelNr].levelUnlocked &&
            game.gamePlay.levels.levels[levelNr].levelStars == 0 {
            return "btn-level-zero-stars"
        } else if game.gamePlay.levels.levels[levelNr].levelUnlocked &&
                    game.gamePlay.levels.levels[levelNr].levelStars == 1 {
            return "btn-level-one-star"
        } else if game.gamePlay.levels.levels[levelNr].levelUnlocked &&
                    game.gamePlay.levels.levels[levelNr].levelStars == 2 {
            return "btn-level-two-stars"
        }  else if game.gamePlay.levels.levels[levelNr].levelUnlocked &&
                    game.gamePlay.levels.levels[levelNr].levelStars == 3 {
            return "btn-level-three-stars"
        } else {
            return "btn-level-locked"
        }
    }
    
    private func setText() -> String {
        if game.gamePlay.levels.levels[levelNr].levelUnlocked {
            return "\(levelNr+1)"
        } else {
            return ""
        }
    }
}

struct LevelBtnView_Previews: PreviewProvider {
    static var previews: some View {
        LevelBtnView(isPreviewShowing: .constant(false), levelNr: 1)
    }
}

