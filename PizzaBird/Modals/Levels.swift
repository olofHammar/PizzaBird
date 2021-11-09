import Foundation
import SwiftUI


struct Levels: Codable {

    var levels: [Level] = [
        Level(levelNr: 0, levelUnlocked: true, levelCompleted: false, score: 0, levelStars: 0,
              threeStars: 60, twoStars: 45, oneStar: 30),
        Level(levelNr: 1, levelUnlocked: false, levelCompleted: false, score: 0, levelStars: 0,
              threeStars: 90, twoStars: 60, oneStar: 30),
        Level(levelNr: 2, levelUnlocked: false, levelCompleted: false, score: 0, levelStars: 0,
              threeStars: 90, twoStars: 60, oneStar: 30),
        Level(levelNr: 3, levelUnlocked: false, levelCompleted: false, score: 0, levelStars: 0,
              threeStars: 90, twoStars: 60, oneStar: 30),
        Level(levelNr: 4, levelUnlocked: false, levelCompleted: false, score: 0, levelStars: 0,
              threeStars: 90, twoStars: 75, oneStar: 45),
        Level(levelNr: 5, levelUnlocked: false, levelCompleted: false, score: 0, levelStars: 0,
              threeStars: 90, twoStars: 75, oneStar: 45),
        Level(levelNr: 6, levelUnlocked: false, levelCompleted: false, score: 0, levelStars: 0,
              threeStars: 60, twoStars: 45, oneStar: 30)
    ]
}

struct Level: Codable {
    
    var levelNr: Int
    var levelUnlocked: Bool
    var levelCompleted: Bool
    var score: Int
    var levelStars: Int
    var threeStars: Int
    var twoStars: Int
    var oneStar: Int
}

