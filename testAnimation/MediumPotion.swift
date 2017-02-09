import Foundation
import SpriteKit
class MediumPotion:HealthPotion {
    
    var tex = SKTexture(imageNamed: "HealthPotion")
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: tex, color: color, size: size)
        name = "item"
        itemName = "Medium Potion"
        self.health = 50
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
