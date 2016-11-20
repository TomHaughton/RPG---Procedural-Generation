import Foundation
import SpriteKit

class UI{
    var ui = SKSpriteNode()
    var dpad: [SKSpriteNode] = []
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
        
        a.name = "a"
        a.size = CGSizeMake(200, 200)
        a.position = CGPointMake(scene.frame.width - 150, 650)
        a.color = UIColor.yellowColor()
        a.texture = SKTexture(imageNamed: "A")
        a.zPosition = 99
        ui.addChild(a)
        
        let up = SKSpriteNode()
        up.name = "up";
        up.size = CGSizeMake(200, 200)
        up.position = CGPointMake(300, 700)
        up.color = UIColor.yellowColor()
        up.texture = SKTexture(imageNamed: "dpadUp")
        dpad.append(up)
        
        let down = SKSpriteNode()
        down.name = "down";
        down.size = CGSizeMake(200, 200)
        down.position = CGPointMake(300, 300)
        down.color = UIColor.yellowColor()
        down.texture = SKTexture(imageNamed: "dpadDown")
        dpad.append(down)
        
        let left = SKSpriteNode()
        left.name = "left";
        left.size = CGSizeMake(200, 200)
        left.position = CGPointMake(100, 500)
        left.color = UIColor.yellowColor()
        left.texture = SKTexture(imageNamed: "dpadLeft")
        dpad.append(left)
        
        let right = SKSpriteNode()
        right.name = "right";
        right.size = CGSizeMake(200, 200)
        right.position = CGPointMake(500, 500)
        right.color = UIColor.yellowColor()
        right.texture = SKTexture(imageNamed: "dpadRight")
        dpad.append(right)
        
        let centre = SKSpriteNode()
        centre.name = "centre";
        centre.size = CGSizeMake(200, 200)
        centre.position = CGPointMake(300, 500)
        centre.color = UIColor.yellowColor()
        centre.texture = SKTexture(imageNamed: "dpadCentre")
        dpad.append(centre)
        
        healthBkg.name = "healthBkg"
        healthBkg.size = CGSizeMake(1600, 150)
        healthBkg.position = CGPointMake(scene.frame.width/2, 1300)
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
        xpBkg.position = CGPointMake(scene.frame.width/2, 1200)
        xpBkg.color = UIColor.brownColor()
        xpBkg.zPosition = 99
        ui.addChild(xpBkg)
        
        xpBar.name = "healthBar"
        xpBar.size = CGSizeMake(CGFloat(1500 / scene.player.xpBoundary) * CGFloat(scene.player.xp), 40)
        xpBar.color = UIColor.greenColor()
        xpBkg.addChild(xpBar)
        
        open.position = CGPointMake(0, 1150)
        open.anchorPoint = CGPointMake(0, 0)
        open.size = CGSizeMake(200, 200)
        open.color = UIColor.redColor()
        open.texture = SKTexture(imageNamed: "inventoryButton")
        open.zPosition = 120
        ui.addChild(open)
        
        for button in dpad{
            button.zPosition = 99
            ui.addChild(button)
        }
    }

}
