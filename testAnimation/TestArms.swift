import Foundation
import SpriteKit
class TestArms: Armour {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        itemName = "Arms"
        defense = 20
        armourType = ArmourType.Heavy
        armourSlot = ArmourSlot.Arms
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
