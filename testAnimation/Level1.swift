import SpriteKit
import AVFoundation

class Level1: GameScene {

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
            player = Player()
            player.gameMode = "S"
            player.position = CGPoint(x: 974, y: 627)
        }
        
        ui = UI(scene: self)
        
        //Village
        let leadHouse = LargeVillagerHouse()
        let leadDoor = Door(texture: SKTexture(imageNamed: "VillageDoor"), color: .redColor(), size: CGSizeMake(100, 100), level: MayorHouse(size: size, player: player))
        let house1 = VillagerHouse()
        let house2 = VillagerHouse()
        let house3 = VillagerHouse()
        let villager = Villager()
        let villager2 = Villager2()
        let qVillager = SideVillager()
        leadDoor.position = CGPointMake(-176, -350)
        leadHouse.position = CGPointMake(-176, -200)
        house1.position = CGPointMake(825, -600)
        house2.position = CGPointMake(500, -100)
        house3.position = CGPointMake(1150, -100)
        villager.position = CGPointMake(-426, 200)
        villager2.position = CGPointMake(1150, -250)
        qVillager.position = CGPointMake(-626, -900)
        
        //Forest
        let wolf = Wolf()
        let wolf2 = Wolf()
        let wolf3 = Wolf()
        wolf.position = CGPointMake(1150, 1400)
        wolf2.position = CGPointMake(1650, 1800)
        wolf3.position = CGPointMake(2000, 2400)
        
        //Bandit camp
        let banditBase = LargeVillagerHouse()
        let banditDoor = Door(texture: SKTexture(imageNamed: "VillageDoor"), color: .redColor(), size: CGSizeMake(100, 100), level: BanditHouse(size: size, player: player))
        let bandit = Bandit()
        let bandit2 = Bandit()
        banditDoor.position = CGPointMake(1880, -850)
        banditBase.position = CGPointMake(1880, -700)
        bandit.position = CGPointMake(banditDoor.position.x + 700, banditDoor.position.y + 100)
        bandit2.position = CGPointMake(banditDoor.position.x + 100, banditDoor.position.y + 700)
        
        //Cave
        let door = Door(texture: nil, color: .clearColor(), size: CGSizeMake(200, 100), level: Cave(size: size, player: player, seed: [], direction: "bottom", location: CGPoint.zero, count: 0))
        door.position = CGPointMake(-276, 2300)
        door.zPosition = 40
        addChild(door)
        
        
        camera = cameraNode
        addChild(background)
        addChild(bkgImg)
        addChild(player)
        addChild(cameraNode)
        
        //Village
        addChild(leadHouse)
        addChild(house1)
        addChild(house2)
        addChild(house3)
        addChild(leadDoor)
        addChild(villager)
        addChild(villager2)
        addChild(qVillager)
        
        //Forest
        addChild(wolf)
        addChild(wolf2)
        addChild(wolf3)
        
        //Bandit Camp
        addChild(banditBase)
        addChild(banditDoor)
        addChild(bandit)
        addChild(bandit2)
        
        cameraNode.addChild(ui.ui)
        camFrame = SKSpriteNode(color: .clearColor(), size: size)
    }
}
