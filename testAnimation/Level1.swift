import SpriteKit

class Level1: GameScene {
    
    let background = SKSpriteNode(imageNamed: "Background")
    var trees: [Scenery] = []
    var box: Item!
    var enemy = RangedEnemy()
    var enemyM = MeleeEnemy()
    
    override func didMoveToView(view: SKView) {
        let door = Door(texture: SKTexture.init(imageNamed: ""), color: UIColor.brownColor(), size: CGSizeMake(100, 100), level: Level2(size: size, player: player))
        player = Player(imageNamed: "PlayerSprite")
        ui = UI(scene: self)
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        
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
        
        door.position = CGPointMake(400, 400)
        door.zPosition = 40
        addChild(door)
        
        player.pickUp(TestSword())
        player.pickUp(TestHelmet())
        
        self.addChild(player)
        self.addChild(background)
        self.addChild(trees[0])
        self.addChild(trees[1])
        self.addChild(box)
        self.addChild(enemy)
        self.addChild(enemyM)
    } 
}
