import SwiftUI

struct WelcomeView: View {
    
    @Binding var isWelcomeViewShowing: Bool
    
    var body: some View {
        ZStack {
            if isWelcomeViewShowing {
                VStack {
                    ZStack {
                        Image("pizza_bird_title")
                            .resizable()
                            .frame(width: 400, height: 400)
                            .padding(.top, UIScreen.main.bounds.height/2.4)
                        
                        Image("pizza_bird_logo")                        .resizable()
                            .frame(width: 400, height: 400)
                            .padding(.bottom, UIScreen.main.bounds.height/3)
                        
                        Text("TAP TO START GAME")
                            .font(.system(size: 24, weight: .heavy, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.top, UIScreen.main.bounds.height/1.2)
                            .onTapGesture {
                                withAnimation{
                                    isWelcomeViewShowing.toggle()
                                }
                            }
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                .padding(34)
                .cornerRadius(24)
                .transition(.move(edge: .leading))
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            WelcomeView(isWelcomeViewShowing: .constant(true))
        }
    }
}
