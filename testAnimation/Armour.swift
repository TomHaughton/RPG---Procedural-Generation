import Foundation
import SpriteKit
class Armour: Item {
    var defense: Int!
    var armourType: ArmourType!
    var armourSlot: ArmourSlot!
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}