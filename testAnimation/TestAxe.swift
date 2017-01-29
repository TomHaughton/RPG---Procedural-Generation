import Foundation
import SpriteKit
class TestAxe:MeleeWeapon {
    
    let tex = SKTexture(imageNamed: "Axe")
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: tex, color: color, size: size)
        itemName = "Axe"
        attack = 43
        weaponType = WeaponType.Axe
        attackSpeed = 1.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
