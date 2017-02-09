import Foundation
import SpriteKit
class LargePotion:HealthPotion {
    
    var tex = SKTexture(imageNamed: "HealthPotion")
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: tex, color: color, size: size)
        name = "item"
        itemName = "Large Potion"
        self.health = 100
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
