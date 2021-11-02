import SwiftUI

struct TopBorder: View {
    
    @EnvironmentObject var game: Game
    @Binding var hearts: Int
    @Binding var totalWeight: Int
    
    var body: some View {
        HStack {
            
            Text("Weight:\n \(game.gamePlay.totalWeight)")
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
                        
                        Text(String(game.gamePlay.hearts))
                            .font(.custom("Luckiest Guy", size: 40, relativeTo: .body))
                            .foregroundColor(.white)
                            .padding(.top, 20)
                    }
                    
                    ZStack {
                        Image("window-title")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.height/18, alignment: .center)
                        Text("3:29")
                            .font(.custom("Luckiest Guy", size: 20, relativeTo: .body))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 1)
                            .shadow(color: .black, radius: 1)
                    }
                    .padding(.top, -35)
                }
                .padding(.bottom, 40)   
        }
        .padding(.leading, 8)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/5.5)
        .background(Color.clear)
    }
}

struct TopBorder_Previews: PreviewProvider {
    static var previews: some View {
        TopBorder(hearts: .constant(5), totalWeight: .constant(100)).environmentObject(Game())
    }
}
