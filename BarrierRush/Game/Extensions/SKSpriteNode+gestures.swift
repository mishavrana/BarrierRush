import Foundation
import SpriteKit
import UIKit

extension SKSpriteNode {
    var swipeDirectionsToWords: [UInt : String] {
        [
            UISwipeGestureRecognizer.Direction.up.rawValue: "up",
            UISwipeGestureRecognizer.Direction.down.rawValue: "down",
            UISwipeGestureRecognizer.Direction.left.rawValue: "left",
            UISwipeGestureRecognizer.Direction.right.rawValue: "right"
        ]
    }
}

