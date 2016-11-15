import SpriteKit

class GameScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "Background")
    var trees: [SKSpriteNode] = []
    var dpad: [SKSpriteNode] = []
    var player: Player!
    var touch:UITouch!
    var box: Item!
    
    var playerAnimationUp:SKAction!
    var playerAnimationDown:SKAction!
    var playerAnimationLeft:SKAction!
    var playerAnimationRight:SKAction!
    var invent = SKLabelNode()
    
    override func didMoveToView(view: SKView) {
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        player = Player(imageNamed: "PlayerSprite")
        
        invent.fontSize = 60
        invent.fontName = "Arial"
        invent.text = String(player.inventory.items)
        invent.position = CGPointMake(CGRectGetMidX(frame) + 200, CGRectGetMidY(frame) + 200)
        invent.color = UIColor.whiteColor()
        invent.zPosition = 200
        
        trees.append(SKSpriteNode(imageNamed: "Tree1"))
        trees.append(SKSpriteNode(imageNamed: "Tree2"))

        player.position = CGPoint(x: size.width/2, y: size.height/2)
        player.zPosition = 10
        player.setScale(1.0)
        
        trees[0].position = CGPoint(x: 1500, y: 500)
        trees[1].position = CGPoint(x: 1650, y: 300)
        trees[0].zPosition = 14
        trees[1].zPosition = 15
        
        //Add item to screen
        box = TestAxe()
        box.texture = SKTexture(imageNamed: "Spaceship")
        box.size = CGSizeMake(100, 100)
        box.position = CGPointMake(CGRectGetMidX(frame) + 300, CGRectGetMidY(frame) - 300)
        box.zPosition = 100
        
        setupDpad()
        self.addChild(invent)
        self.addChild(player)
        self.addChild(background)
        self.addChild(trees[0])
        self.addChild(trees[1])
        self.addChild(box)
        for button in dpad{
            button.zPosition = 120
            self.addChild(button)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touch = touches.first!
    }
   
    override func update(currentTime: CFTimeInterval) {
        if let _ = touch{
            player.move(touch!.locationInNode(self), dpad: dpad, scene: frame)
        }
        
        if CGRectIntersectsRect(box.frame, player.frame) && CGRectIntersectsRect(box.frame, frame) {
            box.removeFromParent()
            player.pickUp(box)
            print(player.inventory.items)
            invent.text = String(player.inventory.items.count)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touch = nil
        player.removeActionForKey("animation")
    }
    
    func setupDpad(){
        let up = SKSpriteNode()
        up.name = "up";
        up.size = CGSizeMake(100, 100)
        up.position = CGPointMake(150, 450)
        up.color = UIColor.yellowColor()
        dpad.append(up)
        
        let down = SKSpriteNode()
        down.name = "down";
        down.size = CGSizeMake(100, 100)
        down.position = CGPointMake(150, 250)
        down.color = UIColor.yellowColor()
        dpad.append(down)
        
        let left = SKSpriteNode()
        left.name = "left";
        left.size = CGSizeMake(100, 100)
        left.position = CGPointMake(50, 350)
        left.color = UIColor.yellowColor()
        dpad.append(left)
        
        let right = SKSpriteNode()
        right.name = "right";
        right.size = CGSizeMake(100, 100)
        right.position = CGPointMake(250, 350)
        right.color = UIColor.yellowColor()
        dpad.append(right)
    }
}
