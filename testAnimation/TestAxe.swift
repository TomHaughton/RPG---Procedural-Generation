import Foundation
import SpriteKit
class TestAxe:Weapon {
    
    let tex = SKTexture(imageNamed: "Spaceship")
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: tex, color: color, size: size)
        itemName = "Axe"
        weight = 15
        attack = 43
        weaponType = WeaponType.Axe
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}