import Foundation
import SpriteKit

class Player: SKSpriteNode {
    
    var runForever = SKAction()
    
    init() {
        let texture = SKTexture(imageNamed: "bird-frame-one")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        self.zPosition = 10
        self.position = CGPoint(x: frame.width / 6, y: frame.height * 0.75)
        
        self.xScale = 0.1
        self.yScale = 0.1
        
        self.physicsBody = SKPhysicsBody(texture: texture, size: self.size)
        self.physicsBody!.contactTestBitMask = self.physicsBody!.collisionBitMask
        self.physicsBody?.isDynamic = false
        self.physicsBody?.collisionBitMask = 0
        
        createAnimations()
        self.run(runForever)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createAnimations() {
        let playerFrameOne = SKTexture(imageNamed: "bird-frame-one")
        let playerFrameTwo = SKTexture(imageNamed: "bird-frame-two")
        let playerFrameThree = SKTexture(imageNamed: "bird-frame-three")
        let playerFrameFour = SKTexture(imageNamed: "bird-frame-four")
        let playerFrameFive = SKTexture(imageNamed: "bird-frame-five")
        let playerFrameSix = SKTexture(imageNamed: "bird-frame-six")
        let playerFrameSeven = SKTexture(imageNamed: "bird-frame-seven")
        let playerFrameEight = SKTexture(imageNamed: "bird-frame-eight")
        let animation = SKAction.animate(with: [playerFrameOne, playerFrameTwo, playerFrameThree, playerFrameFour,
                                                playerFrameFive, playerFrameSix, playerFrameSeven, playerFrameEight], timePerFrame: 0.05)
        runForever = SKAction.repeatForever(animation)
        
    }
}
