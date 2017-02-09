import Foundation
import SpriteKit
class TestSword:MeleeWeapon {
    
    init(){
        super.init(texture: SKTexture(imageNamed: "sword"), color: .clearColor(), size: CGSizeMake(100, 100))
        itemName = "Sword"
        attack = 60
        weaponType = WeaponType.Sword
        attackSpeed = 1.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
