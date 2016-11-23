import SpriteKit

class Level1: GameScene {
    
    var trees: [Scenery] = []
    var box: Item!
    var potion = HealthPotion(texture: nil, color: UIColor.redColor(), size: CGSizeMake(100, 100), health: 50)
    var enemy = RangedEnemy()
    var enemyM = MeleeEnemy()
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    init(size: CGSize, player: Player) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        background = SKSpriteNode(imageNamed: "Background")
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
        
        potion.size = CGSizeMake(100, 100)
        potion.position = CGPointMake(CGRectGetMidX(frame) + 200, CGRectGetMidY(frame) - 300)
        potion.zPosition = 1
        
        let door = Door(texture: SKTexture.init(imageNamed: ""), color: UIColor.brownColor(), size: CGSizeMake(100, 100), level: Level2(size: size, player: player))
        door.position = CGPointMake(400, 400)
        door.zPosition = 40
        addChild(door)
        
        player.pickUp(TestSword())
        player.pickUp(TestHelmet())
        
        camera = cameraNode
        addChild(player)
        addChild(background)
        addChild(trees[0])
        addChild(trees[1])
        addChild(box)
        addChild(enemy)
        addChild(enemyM)
        addChild(cameraNode)
        addChild(potion)
        cameraNode.addChild(ui.ui)
    } 
}
