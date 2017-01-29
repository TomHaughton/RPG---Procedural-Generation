import Foundation
import SpriteKit
class TestSword:MeleeWeapon {
    
    var tex = SKTexture(imageNamed: "sword")
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: tex, color: color, size: size)
        itemName = "Sword"
        attack = 60
        weaponType = WeaponType.Sword
        attackSpeed = 1.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
