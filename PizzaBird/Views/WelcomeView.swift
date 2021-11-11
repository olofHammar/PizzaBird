import SwiftUI

struct WelcomeView: View {
    
    @Binding var isWelcomeViewShowing: Bool
    
    var body: some View {
        ZStack {
            Image("window-card-tall")
                .resizable()
                .padding(.vertical, 70)
                .padding(.horizontal, 20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 2)
                )
            
            VStack {
                
                Image("bird_welcome")
                
                Text("Welcome")
                    .font(.custom("Luckiest Guy", size: 40, relativeTo: .body))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .multilineTextAlignment(.center)
                
                Text("Travel through levels \nand eat pizza.\ngain as much weight\nas possible. ")
                    .font(.custom("Luckiest Guy", size: 25, relativeTo: .body))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                
                Text("Be careful to stay\naway from broccoli!!!. ")
                    .font(.custom("Luckiest Guy", size: 25, relativeTo: .body))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                
                Button(action: {
                    isWelcomeViewShowing.toggle()
                    playSound(sound: "button-push", type: "mp3", repeatNr: 0, volume: 0.5)
                }) {
                    Text("Play ")
                        .font(.custom("Luckiest Guy", size: 70, relativeTo: .body))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 1)
                        .shadow(color: .black, radius: 1)
                        .shadow(color: .black, radius: 1)
                        .shadow(color: .black, radius: 1)
                        .shadow(color: .black, radius: 1)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 50)
            }
            
        }
        .background(Color.black.opacity(0.4))
        .ignoresSafeArea(.all)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            WelcomeView(isWelcomeViewShowing: .constant(true))
        }
    }
}
