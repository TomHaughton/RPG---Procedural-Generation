import SpriteKit

class GameScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "Background")
    var trees: [SKSpriteNode] = []
    var dpad: [SKSpriteNode] = []
    var player: Player!
    var touch:UITouch!
    var box: Item!
    
    var inventory = SKSpriteNode()
    let open = SKSpriteNode()
    let close = SKSpriteNode()
    let head = SKSpriteNode()
    let chest = SKSpriteNode()
    let arms = SKSpriteNode()
    let legs = SKSpriteNode()
    let weapon = SKSpriteNode()
    var slots:[SKSpriteNode] = []
    var bkg: [SKSpriteNode] = []
    var enemy = RangedEnemy()
    
    override func didMoveToView(view: SKView) {
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        player = Player(imageNamed: "PlayerSprite")
        
        enemy = RangedEnemy()
        enemy.size = CGSizeMake(100, 100)
        enemy.color = UIColor.whiteColor()
        enemy.position = CGPoint(x: (size.width/2) + 300, y: (size.height/2) + 300)
        
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

        player.pickUp(box)
        
        setupDpad()
        self.addChild(player)
        self.addChild(background)
        self.addChild(trees[0])
        self.addChild(trees[1])
        self.addChild(box)
        self.addChild(enemy)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touch = touches.first!
        toggleInventory()
    }
   
    override func update(currentTime: CFTimeInterval) {
        enemy.moveToAttack(player)
        if let _ = touch{
            player.move(touch!.locationInNode(self), dpad: dpad, scene: frame)
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
        
        open.position = CGPointMake(0, 1300)
        open.size = CGSizeMake(200, 200)
        open.color = UIColor.redColor()
        open.zPosition = 120
        self.addChild(open)
        
        for button in dpad{
            button.zPosition = 120
            self.addChild(button)
        }
    }
    
    func setupInventoryUI(){
        inventory.size = CGSizeMake(frame.width, frame.height)
        inventory.color = UIColor.whiteColor()
        inventory.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))
        inventory.zPosition = 500
        inventory.name = "inventory"
        
        
        close.position = CGPointMake(-900, 500)
        close.size = CGSizeMake(200, 200)
        close.color = UIColor.redColor()
        
        head.size = CGSizeMake(200, 200)
        head.position = CGPointMake(-550,300)
        head.color = UIColor.brownColor()
        
        chest.size = CGSizeMake(200, 200)
        chest.position = CGPointMake(-550,50)
        chest.color = UIColor.brownColor()
        
        arms.size = CGSizeMake(200, 200)
        arms.position = CGPointMake(-800,50)
        arms.color = UIColor.brownColor()
        
        legs.size = CGSizeMake(200, 200)
        legs.position = CGPointMake(-550,-200)
        legs.color = UIColor.brownColor()
        
        weapon.size = CGSizeMake(200, 200)
        weapon.position = CGPointMake(-300,50)
        weapon.color = UIColor.brownColor()
        
        var x = CGFloat(50)
        var y = CGFloat(400)
        slots = [SKSpriteNode]()
        bkg = [SKSpriteNode]()
        for index in 0...15{
            let itemBkg = SKSpriteNode()
            itemBkg.color = UIColor.brownColor()
            itemBkg.position = CGPointMake(x, y)
            itemBkg.size = CGSizeMake(200, 200)
            
            let slot = SKSpriteNode()
            slot.position = CGPointMake(x, y)
            slot.size = CGSizeMake(200, 200)
            if index < player.inventory.items.count{
                slot.texture = player.inventory.items[index].texture
            }
            y -= 250
            if y <= -400 {
                y = 400
                x += 250
            }
            slots.append(slot)
            bkg.append(itemBkg)
            inventory.addChild(itemBkg)
            inventory.addChild(slot)
        }
        inventory.addChild(close)
        inventory.addChild(head)
        inventory.addChild(chest)
        inventory.addChild(arms)
        inventory.addChild(legs)
        inventory.addChild(weapon)
        addChild(inventory)
    }
    
    func toggleInventory(){
        if childNodeWithName("inventory") != nil && CGRectContainsPoint(close.frame, touch.locationInNode(inventory)){
            inventory.removeFromParent()
            head.removeFromParent()
            chest.removeFromParent()
            arms.removeFromParent()
            weapon.removeFromParent()
            legs.removeFromParent()
            close.removeFromParent()
            for slot in slots{
                slot.removeFromParent()
            }
            for bk in bkg{
                bk.removeFromParent()
            }
        } else if CGRectContainsPoint(open.frame, touch.locationInNode(self)){
            if childNodeWithName("inventory") == nil{
                setupInventoryUI()
            }
        }
    }
}
