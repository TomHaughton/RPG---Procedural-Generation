import Foundation
import SpriteKit
class SmallPotion:HealthPotion {
    
    var tex = SKTexture(imageNamed: "HealthPotion")
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: tex, color: color, size: size)
        name = "item"
        itemName = "Small Potion"
        self.health = 30
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
