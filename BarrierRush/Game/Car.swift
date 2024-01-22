import Foundation
import SpriteKit

class Car: SKSpriteNode {
    private let movementAnimationDuration: TimeInterval = 0.15
    
    private var movementAmount: CGFloat {
        return self.size.width
    }
    
    func move(inDirection direction: UISwipeGestureRecognizer.Direction) {
        switch(direction) {
        case .left:
            moveLeft()
            break
        case .right:
            moveRight()
            break
        default:
            return
        }
        self.animateMovement(inDirection: direction)
    }
    
    private func moveLeft() {
        self.run(SKAction.moveBy(x: -movementAmount, y: 0, duration: movementAnimationDuration))
    }
    
    private func moveRight() {
        self.run(SKAction.moveBy(x: movementAmount, y: 0, duration: movementAnimationDuration))
    }
    
    private func animateMovement(inDirection direction: UISwipeGestureRecognizer.Direction) {
        self.run(SKAction.repeat(createAnimationAction(inDirection: direction), count: 1))
    }
        
    private func createAnimationAction(inDirection direction: UISwipeGestureRecognizer.Direction) -> SKAction {
        let directionWord: String = swipeDirectionsToWords[direction.rawValue] ?? "right"
            
        let animation: SKAction = SKAction.animate(with: [
                SKTexture(imageNamed: "\(directionWord)"),
                SKTexture(imageNamed: "car_sprite")
            ], timePerFrame: movementAnimationDuration)
            
        return animation
    }
}

