import Foundation
import SpriteKit

class HealthPotion:Item{
    var health: Double!
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, health: Double) {
        super.init(texture: texture, color: color, size: size)
        name = "item"
        itemName = "Health Potion"
        self.health = health
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func use(player: Player, index: Int){
        player.health += health
        if player.health > player.maxHealth{
            player.health = player.maxHealth
        }
        player.inventory.items.removeAtIndex(index)
    }
}
