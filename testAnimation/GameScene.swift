import SpriteKit

class GameScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "Background")
    var trees: [SKSpriteNode] = []
    var dpad: [SKSpriteNode] = []
    var player: Player!
    var touch:UITouch!
    var box: Item!
    let open = SKSpriteNode()
    
    var enemy = RangedEnemy()
    var enemyM = MeleeEnemy()
    
    override func didMoveToView(view: SKView) {
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        player = Player(imageNamed: "PlayerSprite")
        
        enemy = TestEnemy()
        enemy.size = CGSizeMake(100, 100)
        enemy.color = UIColor.whiteColor()
        enemy.position = CGPoint(x: (size.width/2) + 300, y: (size.height/2) + 300)
        enemy.name = "enemy"
        
        enemyM = TestMelee()
        enemyM.size = CGSizeMake(100, 100)
        enemyM.color = UIColor.whiteColor()
        enemyM.position = CGPoint(x: (size.width/2) - 300, y: (size.height/2) - 300)
        enemyM.name = "enemy"

        
        trees.append(SKSpriteNode(imageNamed: "Tree1"))
        trees.append(SKSpriteNode(imageNamed: "Tree2"))

        player.position = CGPoint(x: size.width/2, y: size.height/2)
        player.setScale(1.0)
        
        trees[0].position = CGPoint(x: 1500, y: 500)
        trees[1].position = CGPoint(x: 1650, y: 300)
        trees[0].zPosition = 2
        trees[1].zPosition = 2
        
        //Add item to screen
        box = TestAxe()
        box.size = CGSizeMake(100, 100)
        box.position = CGPointMake(CGRectGetMidX(frame) + 300, CGRectGetMidY(frame) - 300)
        box.zPosition = 1

        player.pickUp(TestSword())
        player.pickUp(TestHelmet())
        
        setupUI()
        self.addChild(player)
        self.addChild(background)
        self.addChild(trees[0])
        self.addChild(trees[1])
        self.addChild(box)
        self.addChild(enemy)
        self.addChild(enemyM)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touch = touches.first!
    }
   
    override func update(currentTime: CFTimeInterval) {
        if let _ = touch{
            player.move(touch!.locationInNode(self), dpad: dpad, scene: frame)
            if open.containsPoint(touch.locationInNode(self)) || player.inventory.close.containsPoint(touch.locationInNode(player.inventory.inventory)){
                let toggle = SKAction.runBlock(){
                    self.player.inventory.toggleInventory(self, touch: self.touch, player: self.player)
                    SKAction.waitForDuration(5)
                }
                let wait = SKAction.runBlock(){
                    self.removeActionForKey("toggle")
                }
                if actionForKey("toggle") == nil{
                    runAction(SKAction.sequence([toggle,SKAction.rotateByAngle(0, duration: 0.3),wait]), withKey: "toggle")
                }
            }
            player.inventory.checkEquip(touch, player: player)
        }
        
        enumerateChildNodesWithName("enemy"){ node, _ in
            let enemy = node as! Enemy
            enemy.moveToAttack(self.player)
        }
        
        enumerateChildNodesWithName("item"){ node, _ in
            let item = node as! Item
            if CGRectIntersectsRect(node.frame, self.player.frame) && CGRectIntersectsRect(node.frame, self.frame) {
                node.removeFromParent()
                self.player.pickUp(item)
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touch = nil
        player.removeActionForKey("animation")
    }
    
    func setupUI(){
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
        
        open.position = CGPointMake(0, 1150)
        open.anchorPoint = CGPointMake(0, 0)
        open.size = CGSizeMake(200, 200)
        open.color = UIColor.redColor()
        open.texture = SKTexture(imageNamed: "inventoryButton")
        open.zPosition = 120
        self.addChild(open)
        
        for button in dpad{
            button.zPosition = 99
            self.addChild(button)
        }
    }
}
