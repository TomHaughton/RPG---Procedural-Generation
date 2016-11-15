import Foundation
import SpriteKit
class TestSword:Weapon {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        itemName = "Sword"
        weight = 15
        attack = 43
        weaponType = WeaponType.Sword
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}