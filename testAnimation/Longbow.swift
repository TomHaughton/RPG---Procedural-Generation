import Foundation
import SpriteKit
class Longbow:RangedWeapon {
    
    var tex = SKTexture(imageNamed: "bow")
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: tex, color: color, size: size)
        projTex = SKTexture(imageNamed: "arrow")
        itemName = "Longbow"
        attack = 40
        weaponType = WeaponType.Bow
        attackSpeed = 1.2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
