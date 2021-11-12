import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @EnvironmentObject var game: Game
    @EnvironmentObject var lives: UserLives
    @State var isGameViewShowing = false
    @State var isPreviewShowing = false
    @State var isWelcomeShowing = true
    @State var backgroundMusic: AVAudioPlayer!
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                TopBorder(hearts: $lives.hearts.hearts, totalWeight: $game.gamePlay.totalWeight)
                
                Spacer()
                
                ChapterOneView(isPreviewShowing: $isPreviewShowing)
                    .disabled(lives.hearts.hearts == 0 ? true : false)
                
                Spacer()
                
                ChapterTwoView(isPreviewShowing: $isPreviewShowing)
                    .disabled(lives.hearts.hearts == 0 ? true : false)
                
                Spacer()
            }
            
            if (isWelcomeShowing) {
                WelcomeView(isWelcomeViewShowing: $isWelcomeShowing)
            }
            
            if (isPreviewShowing) {
                LevelPreview(isGameViewShowing: $isGameViewShowing, isPreviewShowing: $isPreviewShowing)
                    .transition(.opacity)
            }
            
            if (isGameViewShowing) {
                GameView(isGameViewShowing: $isGameViewShowing)
                    .transition(.slide)
                    .onAppear {
                        backgroundMusic.volume = 0.8
                        
                    }
                    .onDisappear {
                        backgroundMusic.volume = 0.4
                        lives.hearts.hearts -= 1
                        lives.save()
                    }
            }
        }
        .ignoresSafeArea(.all)
        .onAppear{
            game.gamePlay.isSelectedLevelCompleted = false
            playBackgroundMusic()
            //game.reset()
        }
        .onDisappear{
            backgroundMusic.stop()
        }
    }
    
    
    
    private func playBackgroundMusic() {
        let sound = Bundle.main.path(forResource: "backgroundMusic", ofType: "mp3")
        self.backgroundMusic = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        
        backgroundMusic.volume = 0.4
        backgroundMusic.numberOfLoops = -1
        backgroundMusic.play()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Game()).environmentObject(UserLives())
    }
}
