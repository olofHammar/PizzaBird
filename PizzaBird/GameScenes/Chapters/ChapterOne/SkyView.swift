import SwiftUI

struct SkyView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1142087214, green: 0.5513473054, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.6618374049, green: 0.8975393548, blue: 0.9764705896, alpha: 1))]), startPoint: .bottom, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
    }
}

struct SkyView_Previews: PreviewProvider {
    static var previews: some View {
        SkyView()
    }
}
