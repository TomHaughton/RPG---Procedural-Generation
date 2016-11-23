import Foundation
import SpriteKit
class TestHelmet: Armour {
    
    var tex = SKTexture(imageNamed: "helmet")
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: tex, color: color, size: size)
        itemName = "Helmet"
        defense = 30
        armourType = ArmourType.Heavy
        armourSlot = ArmourSlot.Head
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
