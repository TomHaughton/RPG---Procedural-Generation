import Foundation
import SpriteKit

class UI{
    var ui = SKSpriteNode()
    var dpad: [SKSpriteNode] = []
    var moveStick: SKShapeNode!
    var innerMoveStick: SKShapeNode!
    var attackStick: SKShapeNode!
    var innerAttackStick: SKShapeNode!
    let open = SKSpriteNode()
    let healthBkg = SKSpriteNode()
    let healthBar = SKSpriteNode()
    let xpBkg = SKSpriteNode()
    let xpBar = SKSpriteNode()
    let a = SKSpriteNode()
    
    init(){
    }
    
    init(scene: GameScene){
        setupUI(scene)
    }
    
    func setupUI(scene: GameScene){
        ui.anchorPoint = CGPoint.zero
        ui.position = CGPoint(x: 0 - scene.frame.width/2, y: 0 - scene.frame.height/2)
        
        moveStick = SKShapeNode(circleOfRadius: 250)
        moveStick.name = "moveStick"
        moveStick.position = CGPointMake(300, (scene.overlapAmount() / 2) + 300)
        moveStick.fillColor = UIColor.grayColor()
        moveStick.strokeColor = UIColor.darkGrayColor()
        moveStick.zPosition = 99
        moveStick.alpha = 0.5
        ui.addChild(moveStick)
        
        innerMoveStick = SKShapeNode(circleOfRadius: 100)
        innerMoveStick.name = "moveStick"
        innerMoveStick.fillColor = UIColor.darkGrayColor()
        innerMoveStick.alpha = 1.0
        moveStick.addChild(innerMoveStick)
        
        attackStick = SKShapeNode(circleOfRadius: 250)
        attackStick.name = "attackStick"
        attackStick.position = CGPointMake(scene.size.width - 300, (scene.overlapAmount() / 2) + 300)
        attackStick.fillColor = UIColor.grayColor()
        attackStick.strokeColor = UIColor.darkGrayColor()
        attackStick.zPosition = 99
        attackStick.alpha = 0.7
        ui.addChild(attackStick)
        
        innerAttackStick = SKShapeNode(circleOfRadius: 100)
        innerAttackStick.name = "moveStick"
        innerAttackStick.fillColor = UIColor.darkGrayColor()
        innerAttackStick.alpha = 1.0
        attackStick.addChild(innerAttackStick)
        
        healthBkg.name = "healthBkg"
        healthBkg.size = CGSizeMake(1600, 150)
        healthBkg.position = CGPointMake(scene.frame.width/2, scene.size.height - (scene.overlapAmount() / 2))
        healthBkg.texture = SKTexture(imageNamed: "healthBar")
        healthBkg.zPosition = 99
        ui.addChild(healthBkg)
        
        healthBar.name = "healthBar"
        healthBar.size = CGSizeMake(0, 100)
        if !(scene.player.health <= 0){
            healthBar.size = CGSizeMake(CGFloat(1500 / scene.player.maxHealth) * CGFloat(scene.player.health), 100)
        }
        healthBar.color = UIColor.redColor()
        healthBkg.addChild(healthBar)
        
        xpBkg.name = "healthBkg"
        xpBkg.size = CGSizeMake(1600, 50)
        xpBkg.position = CGPointMake(scene.frame.width/2, scene.size.height - (scene.overlapAmount() / 2) - 100)
        xpBkg.color = UIColor.brownColor()
        xpBkg.zPosition = 99
        ui.addChild(xpBkg)
        
        xpBar.name = "healthBar"
        xpBar.size = CGSizeMake(CGFloat(1500 / scene.player.xpBoundary) * CGFloat(scene.player.xp), 40)
        xpBar.color = UIColor.greenColor()
        xpBkg.addChild(xpBar)
        
        open.position = CGPointMake(0, scene.size.height - (scene.overlapAmount() / 2) - 200)
        open.anchorPoint = CGPointMake(0, 0)
        open.size = CGSizeMake(200, 200)
        open.color = UIColor.redColor()
        open.texture = SKTexture(imageNamed: "inventoryButton")
        open.zPosition = 120
        ui.addChild(open)
    }

}
