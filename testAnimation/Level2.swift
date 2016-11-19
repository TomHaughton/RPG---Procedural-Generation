import SpriteKit

class Level2: GameScene {
    
    let background = SKSpriteNode()
    var trees: [Scenery] = []
    var box: Item!
    var enemy = RangedEnemy()
    var enemyM = MeleeEnemy()
    
    init(size: CGSize, player: Player) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        ui = UI(scene: self)
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.color = UIColor.blueColor()
        
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
        
        trees.append(Scenery(imageNamed: "Tree1"))
        trees.append(Scenery(imageNamed: "Tree2"))
        
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
        self.addChild(box)
        self.addChild(trees[0])
        self.addChild(enemy)
        self.addChild(enemyM)
    }
}
