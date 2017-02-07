import Foundation
import SpriteKit
class AutoRifle:RangedWeapon {
    
    var tex = SKTexture(imageNamed: "pistol")
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: tex, color: color, size: size)
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
