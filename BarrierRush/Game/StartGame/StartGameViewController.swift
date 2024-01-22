import UIKit
import SpriteKit
import GameplayKit

class StartGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = SKView(frame: view.bounds)
        skView.ignoresSiblingOrder = true
        let scene = StartGameScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        view.addSubview(skView)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
