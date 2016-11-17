import SpriteKit

class GameScene: SKScene {
    
    var ui = UI()
    var update = Update()
    let background = SKSpriteNode(imageNamed: "Background")
    var trees: [SKSpriteNode] = []
    var player: Player!
    var touch:UITouch!
    var box: Item!
    
    var enemy = RangedEnemy()
    var enemyM = MeleeEnemy()
    
    override func didMoveToView(view: SKView) {
        ui = UI(scene: self)
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
        
        self.addChild(player)
        self.addChild(background)
        self.addChild(trees[0])
        self.addChild(trees[1])
        self.addChild(box)
//        self.addChild(enemy)
        self.addChild(enemyM)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touch = touches.first!
    }
   
    override func update(currentTime: CFTimeInterval) {
        update.update(self)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touch = nil
        player.removeActionForKey("animation")
    }
    
    }
