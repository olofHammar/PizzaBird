import SwiftUI

struct ChapterCompleted: View {
    
    @EnvironmentObject var game: Game
    @Binding var isGameViewShowing: Bool
    @Binding var isNextLevelSelected: Bool
    @Binding var stars: Int
    @State private var shouldTransition = false
    @State private var twoStars = false
    @State private var threeStars = false
    
    var body: some View {
        ZStack {
            Image("window-card-tall")
                .resizable()
                .frame(width: UIScreen.main.bounds.width/1.5,
                    height: UIScreen.main.bounds.height/2,
                    alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            VStack {
                ZStack {
                    Image("window-title")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width-10, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(.top, 20)
                    HStack {
                        if (!shouldTransition) {
                            Image("star-medium-off")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width/7, height: UIScreen.main.bounds.width/7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                shouldTransition.toggle()
                                        playSound(sound: "xylophone-bonus", type: "wav", repeatNr: 0, volume: 0.8)
                                    }
                                }
                        }
                        
                        if (shouldTransition) {
                            Image("star-medium-on")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width/7, height: UIScreen.main.bounds.width/7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                        
                        if (!twoStars) {
                            Image("star-medium-off")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width/7, height: UIScreen.main.bounds.width/7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding(.top, 12)
                                .onAppear {
                                    if (stars == 2 || stars == 3) {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                                twoStars.toggle()
                                            playSound(sound: "xylophone-bonus", type: "wav", repeatNr: 0, volume: 0.8)
                                        }
                                    }
                                }
                        }
                        
                        if (twoStars) {
                            Image("star-medium-on")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width/7, height: UIScreen.main.bounds.width/7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding(.top, 12)
                        }
                        
                        if (!threeStars) {
                            Image("star-medium-off")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width/7, height: UIScreen.main.bounds.width/7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .onAppear {
                                    if (stars == 3) {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                                                    threeStars.toggle()
                                            playSound(sound: "xylophone-bonus", type: "wav", repeatNr: 0, volume: 0.8)
                                        }
                                    }
                                }
                        }
                        
                        if (threeStars) {
                            Image("star-medium-on")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width/7, height: UIScreen.main.bounds.width/7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                        
                    }
                    .animation(.linear(duration: 0.2), value: shouldTransition)
                    .animation(.linear(duration: 0.2), value: twoStars)
                    .animation(.linear(duration: 0.2), value: threeStars)

                }
                
                Text("Chapter \n Completed")
                    .font(.custom("Luckiest Guy", size: 40, relativeTo: .body))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                
                HStack {
                    Button(action: {
                        isGameViewShowing.toggle()
                        game.save()
                        playSound(sound: "button-push", type: "mp3", repeatNr: 0, volume: 0.5)
                    }) {
                        Image("btn-home")
                            .padding(.trailing, 4)
                    }
                }
                .padding(.top, 20)
            }
            .padding(.bottom, 95)
        }
    }
}

struct ChapterCompleted_Previews: PreviewProvider {
    static var previews: some View {
        ChapterCompleted(isGameViewShowing: .constant(true),
                       isNextLevelSelected: .constant(false), stars: .constant(1)).environmentObject(Game())
    }
}
