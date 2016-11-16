import Foundation
import SpriteKit

class UI{
    
    var dpad: [SKSpriteNode] = []
    let open = SKSpriteNode()
    
    init(){
    }
    
    init(scene: GameScene){
        setupUI(scene)
    }
    
    func setupUI(scene: GameScene){
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
        
        open.position = CGPointMake(0, 1150)
        open.anchorPoint = CGPointMake(0, 0)
        open.size = CGSizeMake(200, 200)
        open.color = UIColor.redColor()
        open.texture = SKTexture(imageNamed: "inventoryButton")
        open.zPosition = 120
        scene.addChild(open)
        
        for button in dpad{
            button.zPosition = 99
            scene.addChild(button)
        }
    }

}
