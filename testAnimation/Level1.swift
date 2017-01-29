import SpriteKit
import AVFoundation

class Level1: GameScene {
    
    
    var box: Item!
    var potion = HealthPotion(texture: nil, color: UIColor.redColor(), size: CGSizeMake(100, 100), health: 50)
//    let musicPath = NSBundle.mainBundle().pathForResource("DemoBacking", ofType: "mp3")
    
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
        self.view!.multipleTouchEnabled = true
//        let fileURL = NSURL(fileURLWithPath: musicPath!)
//        _ = try? musicPlayer = AVAudioPlayer(contentsOfURL: fileURL)
        
//        musicPlayer.play()

        background = SKSpriteNode(imageNamed: "level1bkg")
        background.position = CGPointMake(size.width/2, size.height/2)
        self.backgroundColor = UIColor.darkGrayColor()
        
        let bkgImg = SKSpriteNode(imageNamed: "level1")
        bkgImg.position = CGPointMake(size.width/2, size.height/2)

        bkgImg.physicsBody = SKPhysicsBody(texture: bkgImg.texture!, size: background.size)
        bkgImg.physicsBody?.affectedByGravity = false
        bkgImg.physicsBody?.allowsRotation = false
        bkgImg.physicsBody?.dynamic = false
        
        if player == nil{
            player = Player(imageNamed: "PlayerSprite")
            player.position = CGPoint(x: 974, y: 627)
            
//            player.pickUp(TestSword())
//            player.pickUp(TestHelmet())
//            player.pickUp(TestBow())
            
//            player.questLog.append(BanditQuest(item: TestAxe()))
        }
        
        ui = UI(scene: self)
        
        //Add item to screen
        box = TestAxe()
        box.size = CGSizeMake(100, 100)
        box.position = CGPointMake(CGRectGetMidX(frame) + 300, CGRectGetMidY(frame) - 300)
        box.zPosition = 1
        
        potion.size = CGSizeMake(100, 100)
        potion.position = CGPointMake(CGRectGetMidX(frame) + 200, CGRectGetMidY(frame) - 300)
        potion.zPosition = 1
        
        //Village
        let leadHouse = Scenery(texture: nil, color: .grayColor(), size: CGSizeMake(500, 400))
        leadHouse.position = CGPointMake(-176, -200)
        let leadDoor = Door(texture: SKTexture(imageNamed: "VillageDoor"), color: .redColor(), size: CGSizeMake(100, 100), level: VillagerHouse(size: size, player: player))
        leadDoor.position = CGPointMake(-176, -350)
        let house1 = Scenery(texture: nil, color: .grayColor(), size: CGSizeMake(300, 200))
        house1.position = CGPointMake(825, -600)
        let house2 = Scenery(texture: nil, color: .grayColor(), size: CGSizeMake(300, 200))
        house2.position = CGPointMake(500, -100)
        let house3 = Scenery(texture: nil, color: .grayColor(), size: CGSizeMake(300, 200))
        house3.position = CGPointMake(1150, -100)
        
        let villager = Villager(texture: nil, color: .blueColor(), size: CGSizeMake(100, 100))
        villager.position = CGPointMake(-426, 200)
        let villager2 = Villager2(texture: nil, color: .blueColor(), size: CGSizeMake(100, 100))
        villager2.position = CGPointMake(1150, -250)
        let qVillager = SideVillager(texture: nil, color: .blueColor(), size: CGSizeMake(100, 100))
        qVillager.position = CGPointMake(-626, -900)
        
        
        
        //Forest
        let wolf = Wolf(texture: nil, color: .whiteColor(), size: CGSizeMake(100, 100))
        let wolf2 = Wolf(texture: nil, color: .whiteColor(), size: CGSizeMake(100, 100))
        let wolf3 = Wolf(texture: nil, color: .whiteColor(), size: CGSizeMake(100, 100))
        wolf.position = CGPointMake(1150, 1400)
        wolf2.position = CGPointMake(1650, 1800)
        wolf3.position = CGPointMake(2000, 2400)
        
        
        
        //Bandit camp
        let banditBase = Scenery(texture: nil, color: .grayColor(), size: CGSizeMake(500, 400))
        banditBase.position = CGPointMake(1880, -700)
        let banditDoor = Door(texture: SKTexture(imageNamed: "VillageDoor"), color: .redColor(), size: CGSizeMake(100, 100), level: BanditHouse(size: size, player: player))
        banditDoor.position = CGPointMake(1880, -850)
        
        let bandit = Bandit(texture: nil, color: .whiteColor(), size: CGSizeMake(100, 100))
        let bandit2 = Bandit(texture: nil, color: .whiteColor(), size: CGSizeMake(100, 100))
        bandit.position = CGPointMake(banditDoor.position.x + 700, banditDoor.position.y + 100)
        bandit2.position = CGPointMake(banditDoor.position.x + 100, banditDoor.position.y + 700)
        
        
        
        
        
        let seed:[Int] = []
        let door = Door(texture: nil, color: .clearColor(), size: CGSizeMake(200, 100), level: Cave(size: size, player: player, seed: seed, direction: "bottom", location: CGPoint.zero, count: 0))
        door.position = CGPointMake(-276, 2300)
//        door.position = player.position
        door.zPosition = 40
        addChild(door)
        
        
        
        camera = cameraNode
        addChild(background)
        addChild(bkgImg)
        addChild(player)
        addChild(box)
        addChild(cameraNode)
        addChild(potion)
        addChild(leadHouse)
        addChild(house1)
        addChild(house2)
        addChild(house3)
        addChild(leadDoor)
        addChild(villager)
        addChild(villager2)
        addChild(qVillager)
        
        addChild(wolf)
        addChild(wolf2)
        addChild(wolf3)
        
        addChild(banditBase)
        addChild(banditDoor)
        addChild(bandit)
        addChild(bandit2)
        
        cameraNode.addChild(ui.ui)
        camFrame = SKSpriteNode(color: .clearColor(), size: size)
    }
}
