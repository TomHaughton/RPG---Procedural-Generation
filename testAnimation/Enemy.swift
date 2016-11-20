import Foundation
import SpriteKit

class Enemy: Npc{
    var health: Double! = 100
    var attack: Double! = 10
    var defense: Double! = 3
    var attackSpeed:Double! = 2
    var movementSpeed: Double! = 0.2
    var item: Item?
    var xp: Int = 100
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveToAttack(scene: GameScene){
    }
    
    func checkSurroundings(scene: GameScene, x: CGFloat, y:CGFloat) -> Bool{
        return true
    }
}
