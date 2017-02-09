import Foundation
import SpriteKit
class Longbow:RangedWeapon {
    
    init(){
        super.init(texture: SKTexture(imageNamed: "bow"), color: .clearColor(), size: CGSizeMake(100, 100))
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
