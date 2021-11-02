import Foundation
import SpriteKit
import SwiftUI

class GameSceneChapterOne: SKScene, SKPhysicsContactDelegate {
    
    @Binding var currentWeight: Int
    @Binding var isLevelCompleted: Bool
    @Binding var isRetrySelected: Bool
    @Binding var isGameViewShowing: Bool
    @Binding var level: Int
    
    init(score: Binding<Int>, isLevelCompleted: Binding<Bool>, isRetrySelected: Binding<Bool>,
         isGameViewshowing: Binding<Bool>, level: Binding<Int>) {
        _currentWeight = score
        _isLevelCompleted = isLevelCompleted
        _isRetrySelected = isRetrySelected
        _isGameViewShowing = isGameViewshowing
        _level = level
        super.init(size: CGSize(width: 300, height: 400))
        self.scaleMode = .fill
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
        // super.init(coder: aDecoder)
    }
        
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "ChapterOne")
    var gameOverLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
    var countdownLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "WEIGHT: \(score)"
        }
    }
    var countdown = 3 {
        didSet {
            countdownLabel.text = "\(countdown)"
        }
    }
    var player = Player()
    var gravity = 25
    var rockTexture: SKTexture!
    var rockPhysics: SKPhysicsBody!
    var pizzaTexture: SKTexture!
    var pizzaPhysics: SKPhysicsBody!

    override func didMove(to view: SKView) {
        rockTexture = textureAtlas.textureNamed("blue-rock-obstacle")
        rockPhysics = SKPhysicsBody(texture: rockTexture, size: rockTexture.size())
        pizzaTexture = textureAtlas.textureNamed("pizza-level-one")
        pizzaPhysics = SKPhysicsBody(texture: pizzaTexture, size: pizzaTexture.size())
        
        self.backgroundColor = .clear
        self.addChild(player)
        createBackground()
        createGround()
        createCountdown()
        
        let wait = SKAction.wait(forDuration: 3)
        run(wait, completion: {
            self.startRocks()
            self.player.physicsBody?.isDynamic = true
        })
        createScore()
        //Här sätter jag värden för gravitation så att fågeln sjunker
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -5.0)
        physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var moveForward = true
        var moveUp = true
        
        if player.position.x < frame.width / 3 && player.position.y < frame.height {
            moveForward = false
        } else {
            moveForward = true
        }
        
        if player.position.y < frame.height - 20 {
            moveUp = true
        } else {
            moveUp = false
        }
        
        player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        //Här flyger fågeln upp vid tryck på skärmen
        player.physicsBody?.applyImpulse(CGVector(dx: moveForward ? 0 : 1, dy: moveUp ? gravity : 0))
        
        for touch in (touches ) {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            let transition = SKTransition.flipVertical(withDuration: 0.2)
            
            if nodeTouched.name == "restartGame" {

                let scene = GameSceneChapterOne(score: $currentWeight, isLevelCompleted: $isLevelCompleted, isRetrySelected: $isRetrySelected, isGameViewshowing: $isGameViewShowing, level: $level)
                scene.size = CGSize(width: UIScreen.main.bounds.width,
                                     height: UIScreen.main.bounds.height)
                scene.scaleMode = .aspectFill
                self.view?.presentScene(scene, transition: transition)
            } else if (nodeTouched.name == "closeGame") {
                isGameViewShowing = false
            }
        }
    }
    
    //I denna funktion skapar jag bakgrunden
    func createBackground() {
        let backgroundTexture = textureAtlas.textureNamed("background-mountain")

        for i in 0 ... 1 {
            let background = SKSpriteNode(texture: backgroundTexture)

            background.zPosition = -30
            background.anchorPoint = CGPoint.zero
            //background.size = CGSize(width: frame.width+50, height: frame.height/3)
            background.position = CGPoint(x: (backgroundTexture.size().width * CGFloat(i)) - CGFloat(1 * i), y: -5)
            addChild(background)

            let moveLeft = SKAction.moveBy(x: -backgroundTexture.size().width, y: 0, duration: 20)
            let moveReset = SKAction.moveBy(x: backgroundTexture.size().width, y: 0, duration: 0)
            let moveLoop = SKAction.sequence([moveLeft, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)

            let wait = SKAction.wait(forDuration: 3)
            run(wait, completion: {
                background.run(moveForever)
            })
            
        }
    }
    
    //I denna funktion skapar jag marken
    func createGround() {
        let groundTexture = textureAtlas.textureNamed("ground-grass")

        for i in 0 ... 1 {
            let ground = SKSpriteNode(texture: groundTexture)
            ground.zPosition = -10
            ground.position = CGPoint(x: (groundTexture.size().width / 2.0 + (groundTexture.size().width * CGFloat(i))), y: 10)

            addChild(ground)
            
            let pointTopLeft = CGPoint(x: 0, y: 0)
            let pointTopRight = CGPoint(x: size.width, y: 0)
            ground.physicsBody = SKPhysicsBody(edgeFrom: pointTopLeft,
                                             to: pointTopRight)

            ground.physicsBody = SKPhysicsBody(texture: ground.texture!, size: ground.texture!.size())
            ground.physicsBody?.isDynamic = false

            let moveLeft = SKAction.moveBy(x: -groundTexture.size().width, y: 0, duration: 10)
            let moveReset = SKAction.moveBy(x: groundTexture.size().width, y: 0, duration: 0)
            let moveLoop = SKAction.sequence([moveLeft, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)

            let wait = SKAction.wait(forDuration: 3)
            run(wait,completion: {
                ground.run(moveForever)
            })
        }
    }
  
    //I denna funktion skapar jag hinder och pizza
    func createRocks(rockDistance: CGFloat, yPosition: CGFloat, withPizza: Bool) {
        
        let topRock = SKSpriteNode(texture: rockTexture)
        topRock.physicsBody = rockPhysics.copy() as? SKPhysicsBody
        topRock.physicsBody?.isDynamic = false
        topRock.zRotation = .pi
        //om vi sätter xScale till -1.0 så vänder vi upp och ner på noden.
        topRock.xScale = -1.0
        topRock.zPosition = -20
        
        let bottomRock = SKSpriteNode(texture: rockTexture)
        bottomRock.physicsBody = rockPhysics.copy() as? SKPhysicsBody
        bottomRock.physicsBody?.isDynamic = false
        bottomRock.zPosition = -20
        
        let pizza = SKSpriteNode(texture: pizzaTexture)
        pizza.physicsBody = pizzaPhysics.copy() as? SKPhysicsBody
        pizza.physicsBody?.isDynamic = false
        pizza.zPosition = 0
        pizza.xScale = 1.2
        pizza.name = "weightGain"
        
        addChild(topRock)
        addChild(bottomRock)
        addChild(pizza)
        
        //The default anchor point is (0.5,0.5), so a new SKSpriteNode centers perfectly on its position.
        let xPosition = frame.width + topRock.frame.width
        
        topRock.position = CGPoint(x: xPosition, y: yPosition + topRock.size.height + rockDistance)
        bottomRock.position = CGPoint(x: xPosition, y: yPosition - rockDistance)
        pizza.position = CGPoint(x: xPosition - 50, y: yPosition + bottomRock.size.height/2)

        let endPosition = frame.width + (topRock.frame.width * 2)
        let moveAction = SKAction.moveBy(x: -endPosition, y: 0, duration: 6.2)
        let moveSequence = SKAction.sequence([moveAction, SKAction.removeFromParent()])
        
        topRock.run(moveSequence)
        bottomRock.run(moveSequence)
        
        if withPizza {
            pizza.run(moveSequence)
        }
    }
    
    //I denna funktion skapar jag mållinjen
    func createFlag() {
        let flagTexture = SKTexture(imageNamed: "finish_sign")
        let flag = SKSpriteNode(texture: flagTexture)
        
        flag.zPosition = -20
        flag.yScale = 0.5
        flag.xScale = 0.5
        
        let rockCollision = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 32, height: frame.height*2))
        rockCollision.physicsBody = SKPhysicsBody(rectangleOf: rockCollision.size)
        rockCollision.physicsBody?.isDynamic = false
        rockCollision.name = "finishDetect"
        
        addChild(flag)
        addChild(rockCollision)
        
        let xPosition = frame.width + flag.frame.width
        flag.position = CGPoint(x: xPosition + (flag.size.width * 2), y: frame.minY + 50)
        rockCollision.position = CGPoint(x: xPosition-50 + (flag.size.width * 2), y: frame.height)
        
        let endPosition = frame.width + (flag.frame.width * 2)
        
        let moveAction = SKAction.moveBy(x: -endPosition, y: 0, duration: 6.2)
        flag.run(moveAction)
        rockCollision.run(moveAction)
    }
    
    //I denna funktion skapar jag rörelsen för hinder
    func startRocks() {
        
        let createLowRocks = SKAction.run { [unowned self] in
            self.createRocks(rockDistance: 70, yPosition: 50, withPizza: true)
        }
        let createMediumRocks = SKAction.run { [unowned self] in
            self.createRocks(rockDistance: 70, yPosition: 150, withPizza: false)
        }
        
        let createHighRocks = SKAction.run { [unowned self] in
            self.createRocks(rockDistance: 70, yPosition: 250, withPizza: true)
        }
        let createTightLowRocks = SKAction.run { [unowned self] in
            self.createRocks(rockDistance: 50, yPosition: 50, withPizza: false)
        }

        let wait = SKAction.wait(forDuration: 5)
        
        if level == 1 {
            let runLevelOne = SKAction.sequence([createLowRocks, wait, createHighRocks, wait, createMediumRocks, wait, createMediumRocks, wait, createLowRocks, wait, createLowRocks, wait,
            createTightLowRocks, wait])
            
            run(runLevelOne, completion: {
                self.createFlag()
            })
        } else if level == 2 {
            let runLevelTwo = SKAction.sequence([createHighRocks, wait, createHighRocks, wait, createHighRocks, wait, createLowRocks, wait, createLowRocks, wait, createHighRocks, wait,
            createTightLowRocks, wait])
            
            run(runLevelTwo, completion: {
                self.createFlag()
            })
        } else if level == 3 {
            let runLevelThree = SKAction.sequence([createMediumRocks, wait, createMediumRocks, wait, createTightLowRocks, wait, createTightLowRocks, wait, createTightLowRocks, wait, createTightLowRocks, wait,
            createTightLowRocks, wait])
            
            run(runLevelThree, completion: {
                self.createFlag()
            })
        }
    }
    
    //I denna funktion uppdaterar jag fågelns rotation
    override func update(_ currentTime: TimeInterval) {
        //guard player != nil else { return }
        
        let value = player.physicsBody!.velocity.dy * 0.001
        let rotate = SKAction.rotate(toAngle: value, duration: 0.1)
        
        player.run(rotate)
        
        if isRetrySelected {
            restartLevel()
        }
        
    }
    
    //I denna funktion hanterar jag krockar och målgång
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "weightGain" || contact.bodyB.node?.name == "weightGain" {
            if contact.bodyA.node == player {
                contact.bodyB.node?.removeFromParent()
            } else {
                contact.bodyA.node?.removeFromParent()
            }
            
            let newSizeX = player.xScale * 1.12
            let newSizeY = player.yScale * 1.12
            
            player.xScale = newSizeX
            player.yScale = newSizeY
            
            let newGravity = gravity-2
            
            gravity = newGravity
            
            score += 15
            
            return
        }
        
        if contact.bodyA.node?.name == "finishDetect" || contact.bodyB.node?.name == "finishDetect" {
            if contact.bodyA.node == player {
                contact.bodyB.node?.removeFromParent()
            } else {
                contact.bodyA.node?.removeFromParent()
            }
            
            currentWeight = score
            isLevelCompleted.toggle()
            player.removeFromParent()
            speed = 0
        }
        
        guard contact.bodyA.node != nil && contact.bodyB.node != nil else {
            return
        }
        
        if contact.bodyA.node == player || contact.bodyB.node == player {
            if let explosion = SKEmitterNode(fileNamed: "PlayerExplosion.sks") {
                explosion.position = player.position
                addChild(explosion)
                gameOver()
                restartLevel()
                closeLevel()
            }
            
            player.removeFromParent()
            speed = 0
        }
    }
    
    func createScore() {
        scoreLabel = SKLabelNode(fontNamed: "Luckiest Guy")
        scoreLabel.fontSize = 24
        
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 35)
        scoreLabel.text = "SCORE: 0"
        scoreLabel.fontColor = UIColor.white
        
        addChild(scoreLabel)
    }
    
    func createCountdown() {
        countdownLabel = SKLabelNode(fontNamed: "Luckiest Guy")
        countdownLabel.fontSize = 100
        countdownLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        countdownLabel.text = "3"
        countdownLabel.color = UIColor.white
        
        addChild(countdownLabel)
        
        let countAction = SKAction.run { [unowned self] in
            self.checkCount()
        }
        let wait = SKAction.wait(forDuration: 1)
        
        let countSequence = SKAction.sequence([wait, countAction])
        let repeatCount = SKAction.repeat(countSequence, count: 3)
        
        run(repeatCount)
    }
    
    func checkCount() {
        if countdown == 1 {
            countdownLabel.fontSize = 40
            countdownLabel.text = "PIZZA TIME!!"
            let wait = SKAction.wait(forDuration: 1)
            run(wait, completion: {
                self.countdownLabel.removeFromParent()
            })
        } else {
            countdown -= 1
        }
    }
    
    func gameOver() {
        gameOverLabel = SKLabelNode(fontNamed: "Luckiest Guy")
        gameOverLabel.fontSize = 54
        
        gameOverLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        gameOverLabel.text = "GAME OVER"
        gameOverLabel.fontColor = UIColor.white
        
        addChild(gameOverLabel)
    }
    
    func restartLevel() {
        let restartButton = SKSpriteNode()
        
        restartButton.texture = SKTexture(imageNamed: "btn-restart")
        restartButton.name = "restartGame"
        
        let position = CGPoint(x: frame.midX-40, y: frame.midY-60)
        restartButton.position = position
        
        restartButton.size = CGSize(width: 140, height: 140)
        restartButton.zPosition = 20
        restartButton.xScale = 0.5
        restartButton.yScale = 0.5

        
        addChild(restartButton)
        
        let fadeAnimation =
            SKAction.fadeAlpha(to: 1, duration: 0.4)
        restartButton.run(fadeAnimation)
    }
    
    func closeLevel() {
        let closeButton = SKSpriteNode()
        
        closeButton.texture = SKTexture(imageNamed: "btn-level-close")
        closeButton.name = "closeGame"
        
        let position = CGPoint(x: frame.midX+40, y: frame.midY-60)
        closeButton.position = position
        
        closeButton.size = CGSize(width: 140, height: 140)
        closeButton.zPosition = 20
        closeButton.xScale = 0.5
        closeButton.yScale = 0.5

        
        addChild(closeButton)
        
        let fadeAnimation =
            SKAction.fadeAlpha(to: 1, duration: 0.4)
        closeButton.run(fadeAnimation)
    }
    
}