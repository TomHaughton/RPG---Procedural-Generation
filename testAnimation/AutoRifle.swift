import Foundation
import SpriteKit
class AutoRifle:RangedWeapon {
    
    init(){
        super.init(texture: SKTexture(imageNamed: "AutoRifle"), color: .clearColor(), size: CGSizeMake(100, 100))
        projTex = SKTexture(imageNamed: "bullet")
        itemName = "Auto Rifle"
        attack = 30
        weaponType = WeaponType.Bow
        attackSpeed = 0.2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
