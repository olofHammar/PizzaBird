import SwiftUI
import SpriteKit

struct Hearts: Codable {
    
    var hearts = 5
}

class UserLives: ObservableObject {
    
    @Published var hearts: Hearts
    static let saveKey = "UserLives"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode(Hearts.self, from: data) {
                self.hearts = decoded
                return
            }
        }
        
        self.hearts = Hearts(hearts: 5)
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(hearts) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
    
    func reset() {
        UserDefaults.standard.removeObject(forKey: Self.saveKey)
        
    }
}


