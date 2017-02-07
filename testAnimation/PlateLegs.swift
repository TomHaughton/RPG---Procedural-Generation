import Foundation
import SpriteKit
class PlateLegs: Armour {
    
    var tex = SKTexture(imageNamed: "plateLegs")
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: tex, color: color, size: size)
        itemName = "Plate Legs"
        defense = 70
        armourType = ArmourType.Heavy
        armourSlot = ArmourSlot.Legs
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
