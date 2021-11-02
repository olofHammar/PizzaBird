import SwiftUI

struct BorderView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1562103426, green: 0.1562103426, blue: 0.1562103426, alpha: 1)), Color(#colorLiteral(red: 0.04518276453, green: 0.03062498383, blue: 0.01033328567, alpha: 1))]), startPoint: .bottom, endPoint: .top)
    }
}

struct BorderView_Previews: PreviewProvider {
    static var previews: some View {
        BorderView()
    }
}
