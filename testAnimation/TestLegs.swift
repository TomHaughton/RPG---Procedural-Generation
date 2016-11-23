import Foundation
import SpriteKit
class TestLegs: Armour {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        itemName = "Legs"
        defense = 70
        armourType = ArmourType.Heavy
        armourSlot = ArmourSlot.Legs

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
