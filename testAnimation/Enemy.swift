import Foundation
import SpriteKit

class Enemy: Npc{
    
    struct PhysicsCategory {
        static let None : UInt32 = 0
        static let All : UInt32 = UInt32.max
        static let character : UInt32 = 0b1
    }
    
    var health: Double! = 100
    var attack: Double! = 10
    var defense: Double! = 3
    var attackSpeed:Double! = 2
    var movementSpeed: Double! = 0.2
    var item: Item?
    var xp: Int = 100
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.dynamic = true
        name = "enemy"
        physicsBody?.collisionBitMask = PhysicsCategory.character
        physicsBody?.categoryBitMask = PhysicsCategory.None
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveToAttack(scene: GameScene){
    }
    
    func checkSurroundings(scene: GameScene, x: CGFloat, y:CGFloat) -> Bool{
        return true
    }
    
    func drop(scene:GameScene){
        if let _ = item{
            item?.position = position
            item?.size = CGSizeMake(100, 100)
            scene.addChild(item!)
        }
    }
    
    func takeDamage(scene: GameScene, attack: Double){
        if defense == 0{
            health = health - attack
        }
        else {
            health = health - attack/defense
        }
        
        let dist = position - scene.player.position
        let knock = dist / velocityMag(dist) * 50
        position += knock
        
        if health <= 0 {
            removeFromParent()
            if let room = scene as? Cave{
                room.enemyCount -= 1
                room.enableDoors()
            }
            drop(scene)
            
            //GET RID OF THIS, THIS IS FOR THE PLAYER CLASS
            for quest in scene.player.questLog{
                quest.checkProgress(self, player: scene.player)
            }
            scene.player.xp += self.xp
            if scene.player.xp >= scene.player.xpBoundary{
                scene.player.maxHealth = scene.player.maxHealth + Double(scene.player.level * 10)
                scene.player.level += 1
                scene.player.xpBoundary = scene.player.level * 200
                self.xp = 0
            }
            scene.ui.xpBar.size = CGSizeMake(CGFloat(1500 / scene.player.xpBoundary) * CGFloat(scene.player.xp), 40)
            if !(self.health <= 0){
                scene.ui.healthBar.size = CGSizeMake(CGFloat(1500 / scene.player.maxHealth) * CGFloat(scene.player.health), 100)
            }
        }
    }
}
