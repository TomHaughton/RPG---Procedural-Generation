import Foundation
import SpriteKit

class BanditLeader: MeleeEnemy{
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        attackSpeed = 1.5
        attack = 20
        defense = 3
        item = TestBow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
