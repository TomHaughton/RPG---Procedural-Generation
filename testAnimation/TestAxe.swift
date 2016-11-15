import Foundation
import SpriteKit
class TestAxe:Weapon {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        itemName = "Axe"
        weight = 15
        attack = 43
        weaponType = WeaponType.Axe
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}