import Foundation
import SpriteKit
class PlateArms: Armour {
    
    var tex = SKTexture(imageNamed: "plateArms")
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: tex, color: color, size: size)
        itemName = "Plate Arms"
        defense = 20
        armourType = ArmourType.Heavy
        armourSlot = ArmourSlot.Arms
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
