import Foundation
import SpriteKit
class Pistol:RangedWeapon {
    
    var tex = SKTexture(imageNamed: "pistol")
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: tex, color: color, size: size)
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
