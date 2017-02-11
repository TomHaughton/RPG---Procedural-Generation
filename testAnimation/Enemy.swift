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
    var movementSpeed: CGFloat = 200.0
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
        initItem()
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
        }
        blink()
    }
    
    func blink(){
        let fade = SKAction.runBlock(){
            self.alpha = 0.5
        }
        let unfade = SKAction.runBlock(){
            self.alpha = 1
        }
        let wait = SKAction.runBlock(){
            SKAction.waitForDuration(0.1)
        }
        runAction(SKAction.sequence([fade,wait,unfade]))
    }
    
    func initItem(){
        var itemArray: NSArray?
        if let path = NSBundle.mainBundle().pathForResource("Items", ofType: "plist") {
            itemArray = NSArray(contentsOfFile: path)
        }
        if let arr = itemArray {
            let itemNum = Int(arc4random_uniform(UInt32(arr.count * 4)))
            if itemNum > arr.count - 1 {
                return
            }
            let itemName = "testAnimation." + String(arr[itemNum])
            let aClass = NSClassFromString(itemName) as! Item.Type
            item = aClass.init()
        }
    }
}
