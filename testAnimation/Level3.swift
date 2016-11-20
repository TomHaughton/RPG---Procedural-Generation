import SpriteKit

class Level3: GameScene {
    
    var trees: [Scenery] = []
    var box: Item!
    var enemy = RangedEnemy()
    var enemyM = MeleeEnemy()
    var enemyM2 = MeleeEnemy()
    var enemyM3 = MeleeEnemy()
    
    init(size: CGSize, player: Player) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        ui = UI(scene: self)
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.color = UIColor.greenColor()
        background.size = CGSizeMake(4000, 2000)
        
        enemy = TestEnemy()
        enemy.size = CGSizeMake(100, 100)
        enemy.color = UIColor.whiteColor()
        enemy.position = CGPoint(x: (size.width/2) + 300, y: (size.height/2) + 300)
        enemy.name = "enemy"
        
        enemyM = TestMelee()
        enemyM.size = CGSizeMake(100, 100)
        enemyM.color = UIColor.whiteColor()
        enemyM.position = CGPoint(x: (size.width/2) + 600, y: (size.height/2) + 600)
        enemyM.name = "enemy"
        
        enemyM2 = TestMelee()
        enemyM2.size = CGSizeMake(100, 100)
        enemyM2.color = UIColor.whiteColor()
        enemyM2.position = CGPoint(x: (size.width/2) - 300, y: (size.height/2) + 300)
        enemyM2.name = "enemy"
        
        enemyM2 = TestMelee()
        enemyM2.size = CGSizeMake(100, 100)
        enemyM2.color = UIColor.whiteColor()
        enemyM2.position = CGPoint(x: (size.width/2) - 500, y: (size.height/2) - 300)
        enemyM2.name = "enemy"
        
        trees.append(Scenery(imageNamed: "Tree1"))
        trees.append(Scenery(imageNamed: "Tree2"))
        
        player.position = CGPoint(x: size.width/2, y: size.height/2)
        player.setScale(1.0)
        
        trees[0].position = CGPoint(x: 3000, y: 500)
        trees[1].position = CGPoint(x: 3000, y: 300)
        trees[0].zPosition = 2
        trees[1].zPosition = 2
        
        //Add item to screen
        box = TestAxe()
        box.size = CGSizeMake(100, 100)
        box.position = CGPointMake(CGRectGetMidX(frame) + 300, CGRectGetMidY(frame) - 300)
        box.zPosition = 1
        
        let door = Door(texture: SKTexture.init(imageNamed: ""), color: UIColor.brownColor(), size: CGSizeMake(100, 100), level: Level3(size: size, player: player))
        door.position = CGPointMake(400, 400)
        door.zPosition = 40
        addChild(door)
        
        self.addChild(player)
        self.addChild(background)
        self.addChild(box)
        self.addChild(enemy)
        self.addChild(enemyM)
        self.addChild(enemyM2)
        self.addChild(enemyM3)
        self.addChild(trees[0])
        camera = cameraNode
        self.addChild(cameraNode)
        cameraNode.addChild(ui.ui)
    }
}
