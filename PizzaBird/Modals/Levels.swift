import Foundation
import SwiftUI


struct Levels {

    var levels: [Level] = [
        Level(levelNr: 0, levelUnlocked: false, levelCompleted: false, levelStars: 0),
        Level(levelNr: 1, levelUnlocked: true, levelCompleted: false, levelStars: 0),
        Level(levelNr: 2, levelUnlocked: false, levelCompleted: false, levelStars: 0),
        Level(levelNr: 3, levelUnlocked: false, levelCompleted: false, levelStars: 0),
        Level(levelNr: 4, levelUnlocked: false, levelCompleted: false, levelStars: 0),
        Level(levelNr: 5, levelUnlocked: false, levelCompleted: false, levelStars: 0),
        Level(levelNr: 6, levelUnlocked: false, levelCompleted: false, levelStars: 0)
    ]
}

struct Level {
    
    var levelNr: Int
    var levelUnlocked: Bool
    var levelCompleted: Bool
    var levelStars: Int
}

