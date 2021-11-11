import SwiftUI

@main
struct PizzaBirdApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .statusBar(hidden: true).environmentObject(Game()).environmentObject(UserLives())
        }
    }
}
