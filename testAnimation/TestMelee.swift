import Foundation
import SpriteKit

class TestMelee: MeleeEnemy{
//    
//    struct PhysicsCategory {
//        static let None : UInt32 = 0
//        static let All : UInt32 = UInt32.max
//        static let character : UInt32 = 0b1
//    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        attackSpeed = 2.0
        attack = 20
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
