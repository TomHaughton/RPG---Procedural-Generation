import Foundation
import SpriteKit
class Pistol:RangedWeapon {
    
    init(){
        super.init(texture: SKTexture(imageNamed: "pistol"), color: .clearColor(), size: CGSizeMake(100, 100))
        projTex = SKTexture(imageNamed: "bullet")
        itemName = "Pistol"
        attack = 43
        weaponType = WeaponType.Bow
        attackSpeed = 1.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
