import Foundation
import SpriteKit

class Bandit: MeleeEnemy{
    
    init() {
        super.init(texture: SKTexture(imageNamed:"bandit"), color: .clearColor(), size: CGSizeMake(100, 100))
        addChild(TestSword())
        attackSpeed = 2.0
        attack = 20
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
