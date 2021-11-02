import Foundation
import SwiftUI

extension Button {
    
    func blueButton() -> some View {
        self
            .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/18, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding()
            .font(Font.custom("Optima-ExtraBlack", size: 26))
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white, lineWidth: 8)
            )
            .background(Color.blue)
            .cornerRadius(12)
    }
}
