import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    
    private let passedObstacles: Int
    private let restartButton = SKSpriteNode(imageNamed: "play_again")
    private let scoreLabel = SKLabelNode(fontNamed: "Inter")
    private let gameOverLabel = SKLabelNode(fontNamed: "Inter-Bold")
    
    init(size: CGSize, passedObstacles: Int) {
        self.passedObstacles = passedObstacles
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        setupUI()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if let node = self.nodes(at: location).first, node.name == "restartButton" {
                restartGame()
            }
        }
    }
    
    // MARK: - Set-up UI
    
    private func setupUI() {
        
        // Set-up Restart Button
        
        restartButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        restartButton.name = "restartButton"
        addChild(restartButton)
        
        //Set-up Score Label
        
        scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        scoreLabel.name = "scoreLabel"
        scoreLabel.text = "Your score is: \(passedObstacles)"
        scoreLabel.fontColor = .black
        scoreLabel.fontSize = 30
        addChild(scoreLabel)
        
        // Set-up GameOverLabel
        
        gameOverLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
        gameOverLabel.name = "gameOverLabel"
        gameOverLabel.text = "GAME OVER"
        gameOverLabel.fontColor = .black
        gameOverLabel.fontSize = 40
        addChild(gameOverLabel)
    }
    
    // MARK: - Intents

    private func restartGame() {
        let scene = GameScene(size: size)
        self.view?.presentScene(scene)
    }
}
