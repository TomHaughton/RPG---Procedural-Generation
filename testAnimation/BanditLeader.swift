import Foundation
import SpriteKit

class BanditLeader: MeleeEnemy{
    
    init(){
        super.init(texture: nil, color: .clearColor(), size: CGSizeMake(100, 100))
        attackSpeed = 1.5
        attack = 20
        defense = 3
        item = Pistol()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
