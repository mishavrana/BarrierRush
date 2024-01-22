import Foundation
import SpriteKit

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let carBody: SKPhysicsBody
        let coneBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask {
            carBody = contact.bodyA
            coneBody = contact.bodyB
        } else {
            carBody = contact.bodyB
            coneBody = contact.bodyA
        }
        
        if
            carBody.categoryBitMask & PhysicsCategory.car != 0
            &&
            coneBody.categoryBitMask & PhysicsCategory.cone != 0
        {
            
            if
                let carFrame = carBody.node?.frame,
                let coneFrame = coneBody.node?.frame,
                carFrame.midY < coneFrame.minY
                
            {
                carDidCollideWithCone()
            }
            
        }
    }
}

