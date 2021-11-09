import Foundation
import SpriteKit
import SwiftUI
import AVFoundation

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
    
    //Labels
    var gameOverLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
    var countdownLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Weight: \(score)"
        }
    }
    var countdown = 3 {
        didSet {
            countdownLabel.text = "\(countdown)"
        }
    }
    
    //Items
    var player = Player()
    var gravity = 25
    var rockTexture: SKTexture!
    var rockPhysics: SKPhysicsBody!
    var pizzaTexture: SKTexture!
    var pizzaPhysics: SKPhysicsBody!
    var broccoliTexture: SKTexture!
    var broccoliPhysics: SKPhysicsBody!
    
    //Sound
    let pizzaSound = SKAction.playSoundFileNamed("pizza-pickup", waitForCompletion: false)



    override func didMove(to view: SKView) {
        rockTexture = textureAtlas.textureNamed("blue-rock-obstacle")
        rockPhysics = SKPhysicsBody(texture: rockTexture, size: rockTexture.size())
        pizzaTexture = textureAtlas.textureNamed("pizza")
        pizzaPhysics = SKPhysicsBody(texture: pizzaTexture, size: pizzaTexture.size())
        broccoliTexture = textureAtlas.textureNamed("broccoli")
        broccoliPhysics = SKPhysicsBody(texture: broccoliTexture, size: broccoliTexture.size())
        
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
                playSound(sound: "button-push", type: "mp3", repeatNr: 0, volume: 0.5)
                
            } else if (nodeTouched.name == "closeGame") {
                isGameViewShowing = false
                playSound(sound: "button-push", type: "mp3", repeatNr: 0, volume: 0.5)
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
    func createRocks(rockDistance: CGFloat, yPosition: CGFloat, withPizza: Bool, withBroccoli: Bool) {
        
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
        pizza.xScale = 1
        pizza.name = "weightGain"
        
        let broccoli = SKSpriteNode(texture: broccoliTexture)
        broccoli.physicsBody = broccoliPhysics.copy() as? SKPhysicsBody
        broccoli.physicsBody?.isDynamic = false
        broccoli.zPosition = 0
        broccoli.xScale = 1
        broccoli.name = "weightLoss"
        
        addChild(topRock)
        addChild(bottomRock)
        addChild(pizza)
        addChild(broccoli)
        
        //The default anchor point is (0.5,0.5), so a new SKSpriteNode centers perfectly on its position.
        let xPosition = frame.width + topRock.frame.width
        
        topRock.position = CGPoint(x: xPosition, y: yPosition + topRock.size.height + rockDistance)
        bottomRock.position = CGPoint(x: xPosition, y: yPosition - rockDistance)
        pizza.position = CGPoint(x: xPosition - 50, y: yPosition + bottomRock.size.height/2)
        broccoli.position = CGPoint(x: xPosition - 50, y: yPosition + bottomRock.size.height/2)

        let endPosition = frame.width + (topRock.frame.width * 2)
        let moveAction = SKAction.moveBy(x: -endPosition, y: 0, duration: 6.2)
        let moveSequence = SKAction.sequence([moveAction, SKAction.removeFromParent()])
        
        topRock.run(moveSequence)
        bottomRock.run(moveSequence)
        
        if withPizza {
            pizza.run(moveSequence)
        } else if (withBroccoli) {
            broccoli.run(moveSequence)
        }
    }
    
    //I denna funktion skapar jag mållinjen
    func createFlag() {
        let flagTexture = SKTexture(imageNamed: "finish_chapter_one")
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
        
        let createLowRocksWithPizza = SKAction.run { [unowned self] in
            self.createRocks(rockDistance: 70, yPosition: 100, withPizza: true, withBroccoli: false)
        }
        let createMediumRocks = SKAction.run { [unowned self] in
            self.createRocks(rockDistance: 70, yPosition: 150, withPizza: false, withBroccoli: false)
        }
        
        let createHighRocksWithPizza = SKAction.run { [unowned self] in
            self.createRocks(rockDistance: 70, yPosition: 250, withPizza: true, withBroccoli: false)
        }
        
        let createHighRocks = SKAction.run { [unowned self] in
            self.createRocks(rockDistance: 70, yPosition: 250, withPizza: false, withBroccoli: false)
        }
        
        let createTightLowRocks = SKAction.run { [unowned self] in
            self.createRocks(rockDistance: 70, yPosition: 100, withPizza: false, withBroccoli: false)
        }
        
        let createTightHighRocks = SKAction.run { [unowned self] in
            self.createRocks(rockDistance: 15, yPosition: 200, withPizza: false, withBroccoli: false)
        }
        
        let createHighRocksWithBroccoli = SKAction.run { [unowned self] in
            self.createRocks(rockDistance: 70, yPosition: 250, withPizza: false, withBroccoli: true)
        }

        let wait = SKAction.wait(forDuration: 5)
        
        if level == 0 {
            let runLevelOne = SKAction.sequence([createLowRocksWithPizza, wait, createHighRocksWithBroccoli, wait,  createHighRocksWithPizza, wait, createMediumRocks, wait, createMediumRocks, wait, createLowRocksWithPizza, wait, createLowRocksWithPizza, wait, createTightLowRocks, wait])
            
            run(runLevelOne, completion: {
                self.createFlag()
            })
        } else if level == 1 {
            let runLevelTwo = SKAction.sequence([createHighRocksWithPizza, wait, createHighRocksWithPizza, wait, createHighRocksWithPizza, wait, createLowRocksWithPizza, wait, createLowRocksWithPizza, wait, createHighRocksWithPizza, wait, createTightLowRocks, wait])
            
            run(runLevelTwo, completion: {
                self.createFlag()
            })
        } else if level == 2 {
            let runLevelThree = SKAction.sequence([createMediumRocks, wait, createHighRocksWithPizza, wait, createTightLowRocks, wait, createTightLowRocks, wait, createHighRocksWithPizza, wait, createTightLowRocks, wait, createTightLowRocks, wait, createHighRocksWithPizza, wait, createHighRocksWithPizza, wait, createLowRocksWithPizza, wait, createHighRocksWithBroccoli, wait, createHighRocksWithPizza, wait, createHighRocksWithPizza, wait, createHighRocks, wait])
            
            run(runLevelThree, completion: {
                self.createFlag()
            })
        } else if level == 3 {
            let runLevelFour = SKAction.sequence([createHighRocksWithPizza, wait, createLowRocksWithPizza, wait,
                createHighRocksWithPizza, wait, createLowRocksWithPizza, wait, createTightLowRocks, wait, createTightHighRocks, wait, createTightLowRocks, wait, createHighRocksWithPizza, wait, createTightHighRocks, wait, createTightLowRocks, wait, createTightHighRocks, wait, createHighRocksWithPizza, wait])
            
            run(runLevelFour, completion: {
                self.createFlag()
            })
        } else if level == 4 {
            let runLevelFive = SKAction.sequence([createLowRocksWithPizza, wait, createHighRocksWithBroccoli, wait, createHighRocksWithPizza, wait, createTightHighRocks, wait, createHighRocksWithBroccoli, wait, createHighRocksWithBroccoli, wait, createHighRocksWithPizza, wait, createLowRocksWithPizza, wait, createHighRocksWithPizza, wait, createTightHighRocks, wait, createHighRocksWithPizza, wait, createMediumRocks, wait, createLowRocksWithPizza, wait, createMediumRocks, wait, createTightHighRocks, wait])
            
            run(runLevelFive, completion: {
                self.createFlag()
            })
        } else if level == 5 {
            let runLevelSix = SKAction.sequence([createTightLowRocks, wait, createTightHighRocks, wait, createHighRocksWithBroccoli, wait, createHighRocksWithBroccoli, wait, createHighRocksWithPizza, wait, createMediumRocks, wait, createHighRocksWithPizza, wait, createTightHighRocks, wait, createLowRocksWithPizza, wait, createLowRocksWithPizza, wait, createTightHighRocks, wait, createMediumRocks, wait, createTightHighRocks, wait, createLowRocksWithPizza, wait, createTightHighRocks, wait, createHighRocksWithPizza, wait, createTightHighRocks, wait, createMediumRocks, wait, createTightHighRocks, wait, createTightHighRocks, wait, createTightLowRocks, wait, createTightHighRocks, wait])
            
            run(runLevelSix, completion: {
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
            
            playSound(sound: "pizza-pickup", type: "mp3", repeatNr: 0, volume: 0.6)
                        
            return
        }
        
        if contact.bodyA.node?.name == "weightLoss" || contact.bodyB.node?.name == "weightLoss" {
            if contact.bodyA.node == player {
                contact.bodyB.node?.removeFromParent()
            } else {
                contact.bodyA.node?.removeFromParent()
            }
            
            let newSizeX = player.xScale * 0.88
            let newSizeY = player.yScale * 0.88
            
            player.xScale = newSizeX
            player.yScale = newSizeY
            
            let newGravity = gravity+2
            
            gravity = newGravity
            
            score -= 15
            
            playSound(sound: "broccoli-pickup", type: "mp3", repeatNr: 0, volume: 0.9)
            
            return
        }
        
        guard contact.bodyA.node != nil && contact.bodyB.node != nil else {
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
            scoreLabel.removeFromParent()
            speed = 0
            playSound(sound: "level-completed", type: "wav", repeatNr: 0, volume: 0.6)
            
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
                playSound(sound: "explosion", type: "wav", repeatNr: 0, volume: 0.4)
            }
            
            player.removeFromParent()
            speed = 0
        }
    }
    
    func createScore() {
        scoreLabel = SKLabelNode(fontNamed: "Luckiest Guy")
        scoreLabel.fontSize = 24
        
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 55)
        scoreLabel.text = "Weight: 0"
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
        
        let position = CGPoint(x: frame.midX-60, y: frame.midY-60)
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
        
        let position = CGPoint(x: frame.midX+60, y: frame.midY-60)
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
