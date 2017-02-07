import Foundation
import SpriteKit
class PlateChest: Armour {
    
    var tex = SKTexture(imageNamed: "plateChest")
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: tex, color: color, size: size)
        itemName = "Chest"
        defense = 70
        armourType = ArmourType.Heavy
        armourSlot = ArmourSlot.Chest
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
