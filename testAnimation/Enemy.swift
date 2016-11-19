import Foundation
import SpriteKit

class Enemy: Npc{
    var health: Double! = 100
    var attack: Double! = 10
    var defense: Double! = 10
    var attackSpeed:Double! = 2
    var movementSpeed: Double! = 0.2
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
