import Foundation
import SpriteKit

class Door: Scenery {
    
    var level:GameScene!
    var enabled = true
    
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
        if enabled{
            let nextScene = level
            if let thisCave = current as? Cave{
                let enClear = thisCave.enemyCount == 0 ? true : false
                let itClear = thisCave.enemyCount == 0 ? true : false
                
                let thisRoom = DungeonRoom(location: thisCave.location, enemiesClear: enClear, itemsClear: itClear)
                
                if !thisCave.rooms.contains(thisRoom){
                    thisCave.rooms.append(thisRoom)
                }
                if let next = nextScene as? Cave{
                    next.rooms = thisCave.rooms
                    next.clearCount = thisCave.clearCount
                }
            }
            current.player.removeFromParent()
            level.player = current.player
            nextScene.scaleMode = scene!.scaleMode
            let reveal = SKTransition.fadeWithDuration(1)
            scene!.view?.presentScene(nextScene, transition: reveal)
        }
    }
}
