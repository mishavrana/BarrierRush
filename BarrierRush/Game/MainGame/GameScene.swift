import SpriteKit


class GameScene: SKScene {
    
    private var passedObstacles = 0
    private var coneSpeed: Double = 4.0
    
    private let car = Car(imageNamed: "car_sprite")
    private let obstaclesLabel = SKLabelNode(fontNamed: "Inter-Bold")
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        
        setupCar()
        setupObstaclesLabel()
        increaseConeSpeed()
        setupGentures(for: view)
        setupMusic()
        
        run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run(setupCone),
            SKAction.wait(forDuration: 1.0)
        ])))
    }
    
    
    // MARK: - Setting the car_sprite
    
    private func setupCar() {
        // Setup physics
        car.physicsBody = SKPhysicsBody(rectangleOf: car.size)
        car.physicsBody!.categoryBitMask = PhysicsCategory.car
        car.physicsBody!.contactTestBitMask = PhysicsCategory.cone
        car.physicsBody!.collisionBitMask = PhysicsCategory.none
        
        car.position = CGPoint(x: size.width * 0.5, y: size.height * 0.1)
        addChild(car)
        
    }
    
    // MARK: - Setting the cone_sprite
    
    private func setupCone() {
        let cone = SKSpriteNode(imageNamed: "cone_sprite")
        
        // Set-up physics
        
        cone.physicsBody = SKPhysicsBody(rectangleOf: cone.size)
        cone.physicsBody!.isDynamic = true
        cone.physicsBody!.categoryBitMask = PhysicsCategory.cone
        cone.physicsBody!.contactTestBitMask = PhysicsCategory.car
        cone.physicsBody!.collisionBitMask = PhysicsCategory.none
        cone.physicsBody!.usesPreciseCollisionDetection = true
        
        // Determine the position of the cone
        
        let actualX = random(min: cone.size.width/2, max: size.width - cone.size.width / 2)
        let actualY = size.height + cone.size.height
        
        cone.position = CGPoint(x: actualX, y: actualY)
        addChild(cone)
        
        // Create a move action for cone
        
        let actionMove = SKAction.move(
          to: CGPoint(x: actualX, y: -cone.size.height/2),
          duration: TimeInterval(coneSpeed)
        )
        
        let actionMoveDone = SKAction.removeFromParent()
        let giveScore = SKAction.run { [weak self] in
            if let passedObstacles = self?.passedObstacles {
                self?.passedObstacles += 1
                self?.obstaclesLabel.text = "\(passedObstacles)"
            } 
        }
        
        cone.run(SKAction.sequence([actionMove, actionMoveDone, giveScore]))
    }
    
    private func increaseConeSpeed() {
        run(
            SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.wait(forDuration: 2),
                    SKAction.run {[weak self] in
                        self?.coneSpeed *= 0.9
                        
                        if let coneSpped = self?.coneSpeed, coneSpped < 2 {
                            self?.removeAction(forKey: "increaseSpeed")
                        }
                    }
                ])
            ), withKey: "increaseSpeed"
        )
    }
    
    // MARK: - Setting up the count label
    
    private func setupObstaclesLabel() {
        obstaclesLabel.fontSize = 40
        obstaclesLabel.text = "0"
        obstaclesLabel.fontColor = SKColor.black
        obstaclesLabel.position = CGPoint(
            x: size.width * 0.5,
            y: size.height * 0.85
        )
        addChild(obstaclesLabel)
    }
    
    // MARK: - Setting up the music
    
    private func setupMusic() {
        let backgroundMusic = SKAudioNode(fileNamed: "background_music.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
    }
    
    // MARK: - Adding swipe gestures recognisers
    
    private func setupGentures(for view: SKView) {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(sender:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(sender:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
    }
    
    @objc private func swipeRight(sender: UISwipeGestureRecognizer) {
        car.move(inDirection: sender.direction)
    }
       
    @objc private func swipeLeft(sender: UISwipeGestureRecognizer) {
        car.move(inDirection: sender.direction)
    }
    
    // MARK: - Handle Collisions
    
    func carDidCollideWithCone() {
        let feedback = UINotificationFeedbackGenerator()
        feedback.notificationOccurred(.error)
        
        let gameOverScene = GameOverScene(
            size: size,
            passedObstacles: passedObstacles
        )
        self.view?.presentScene(gameOverScene)
    }

    
    // MARK: Helpers
    
    private func randomNumber() -> CGFloat {
        let randomUInt32 = arc4random()
        let normalizedRandom = CGFloat(randomUInt32) / CGFloat(UInt32.max)
        return normalizedRandom
    }
    
    private func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return randomNumber() * (max - min) + min
    }
}
