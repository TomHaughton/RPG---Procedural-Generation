import Foundation
import SpriteKit
class TestBow:Weapon {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        itemName = "Bow"
        attack = 43
        weaponType = WeaponType.Bow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
