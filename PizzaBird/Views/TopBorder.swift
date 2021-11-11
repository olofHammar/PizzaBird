import SwiftUI
import Combine

struct TopBorder: View {
    
    @EnvironmentObject var game: Game
    @EnvironmentObject var lives: UserLives
    @Binding var hearts: Int
    @Binding var totalWeight: Int
    @State var timerIsPaused = true
    @State private var timeRemaining = 90
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            
            Text("Weight:\n \(totalWeight)")
                .font(.custom("Luckiest Guy", size: 40, relativeTo: .body))
                .foregroundColor(.white)
                .shadow(color: .black, radius: 1)
                .shadow(color: .black, radius: 1)
                .shadow(color: .black, radius: 1)
                .shadow(color: .black, radius: 1)
                .shadow(color: .black, radius: 1)
            
            Spacer()
            
            VStack {
                ZStack {
                    Image("obj-heart")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width/5.5, height: UIScreen.main.bounds.height/10, alignment: .leading)
                        .shadow(color: .white, radius: 18, x: 1.0, y: 1.0)
                    
                    Text(String(hearts))
                        .font(.custom("Luckiest Guy", size: 40, relativeTo: .body))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                }
                
                ZStack {
                    Image("window-title")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.height/18, alignment: .center)
                    Text(timerIsPaused ? "Full" : "\(convertSeconds(time: timeRemaining))")
                        .font(.custom("Luckiest Guy", size: 20, relativeTo: .body))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 1)
                        .shadow(color: .black, radius: 1)
                        .onReceive(timer) { time in
                            if hearts == 5 {
                                print("full lives.")
                                timerIsPaused = true
                            } else {
                                timerIsPaused = false
                                if self.timeRemaining > 0 {
                                    self.timeRemaining -= 1
                                } else {
                                    hearts += 1
                                    self.timeRemaining = 90
                                }
                            }
                            lives.save()
                        }
                }
                .padding(.top, -30)
            }
            .padding(.bottom, 40)
        }
        .padding(.leading, 8)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/5.5)
        .background(Color.clear)
    }
    
    private func convertSeconds(time: Int) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}

struct TopBorder_Previews: PreviewProvider {
    static var previews: some View {
        TopBorder(hearts: .constant(5), totalWeight: .constant(100)).environmentObject(Game())
    }
}
