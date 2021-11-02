import SwiftUI
import SpriteKit

struct GamePlay {
    
    var hearts: Int
    var selectedLevel: SKScene!
    var levels: Levels
    //var levelName: String
    var levelNr: Int
    var currentLevelWeight: Int
    var totalWeight: Int
    var isSelectedLevelCompleted: Bool
    var isRetrySelected: Bool
}

class Game: ObservableObject {
    @Published var gamePlay: GamePlay = GamePlay.init(hearts: 5, selectedLevel: nil, levels: Levels.init(), levelNr: 0, currentLevelWeight: 0, totalWeight: 0, isSelectedLevelCompleted: false, isRetrySelected: false)
}
