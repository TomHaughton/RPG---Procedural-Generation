import Foundation
import SpriteKit

class Door: Scenery {
    
    var level:GameScene!
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        name = "scenery"
    }
    
    convenience init(texture: SKTexture?, color: UIColor, size: CGSize, level: GameScene) {
        self.init(texture: texture, color: color, size: size)
        name = "door"
        self.level = level
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadLevel(current:GameScene){
        let nextScene = level
        current.player.removeFromParent()
        level.player = current.player
        nextScene.scaleMode = scene!.scaleMode
        let reveal = SKTransition.fadeWithDuration(0.5)
        scene!.view?.presentScene(nextScene, transition: reveal)
    }
}