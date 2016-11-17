import Foundation
import SpriteKit

class Enemy: Npc{
    var health: Int!
    var attack: Int!
    var defense: Int!
    var attackSpeed:Double!
    var movementSpeed: Int!
    var item: Item?
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveToAttack(scene: GameScene){
    }
}
