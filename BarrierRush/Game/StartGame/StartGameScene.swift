import Foundation
import SpriteKit
import SwiftUI

class StartGameScene: SKScene {
    
    private let playButton = SKSpriteNode(imageNamed: "play_button")
    private let pressToPlayLabel = SKLabelNode(fontNamed: "Inter-Bold")
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(Color("main_orange"))
        setupPlayButton()
        setupPressToPlayLabel()
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if let node = self.nodes(at: location).first, node.name == "playButton" {
                startGame()
            }
        }
    }
    
    // MARK: - Setup play button
    private func setupPlayButton() {
        playButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        playButton.name = "playButton"
        addChild(playButton)
    }
    
    // MARK: - Setup press to play label
    private func setupPressToPlayLabel() {
        pressToPlayLabel.fontSize = 40
        pressToPlayLabel.text = "PRESS TO PLAY"
        pressToPlayLabel.fontColor = .white
        pressToPlayLabel.position = CGPoint(
            x: self.frame.midX,
            y: self.frame.midY + 100
        )
        addChild(pressToPlayLabel)
    }
    
    // MARK: - Intents
    private func startGame() {
        let rotateAction = SKAction.rotate(byAngle: 360, duration: 0.5)
        playButton.run(rotateAction) { [weak self] in
            let gameScene = GameScene(size: self?.size ?? .zero)
            self?.view?.presentScene(gameScene)
        }
    }
}
