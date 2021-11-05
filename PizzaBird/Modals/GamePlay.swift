import SwiftUI
import SpriteKit

struct GamePlay: Codable {

    var hearts = 5
    var levels = Levels.init()
    var levelNr = 0
    var currentLevelWeight = 0
    var totalWeight = 0
    var isSelectedLevelCompleted = false
    var isRetrySelected = false
    
}

class Game: ObservableObject {
    
    @Published var gamePlay: GamePlay
    static let saveKey = "SavedData"

    init() {
            if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
                if let decoded = try? JSONDecoder().decode(GamePlay.self, from: data) {
                    self.gamePlay = decoded
                    return
                }
            }

        self.gamePlay = GamePlay(hearts: 5, levels: Levels.init(), currentLevelWeight: 0, totalWeight: 0, isSelectedLevelCompleted: false, isRetrySelected: false)
        }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(gamePlay) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
}

