import SwiftUI

struct GameOverView: View {
    
    @EnvironmentObject var game: Game
    @Binding var isGameViewShowing: Bool
    @Binding var isGamePaused: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: UIScreen.main.bounds.width/1.4, height: UIScreen.main.bounds.height/2, alignment: .center)
                .overlay(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1142087214, green: 0.5513473054, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.6618374049, green: 0.8975393548, blue: 0.9764705896, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(12)
                .shadow(radius: 12)
            VStack {
                
                Text("Game Over")
                    .font(.system(size: 34, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.bottom, -50)
                Image("dizzy_bird")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, -70)
                
                Button {
                    isGameViewShowing.toggle()
                } label: {
                    Text("CONTINUE")
                }
                .blueButton()
            }
            .frame(width: UIScreen.main.bounds.width/1.4, height: UIScreen.main.bounds.height/2, alignment: .center)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
        .background(Color.black.opacity(0.2))
        .ignoresSafeArea(.all)
        .onAppear {
            isGamePaused.toggle()
        }
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(isGameViewShowing: .constant(true), isGamePaused: .constant(true))
    }
}
