import SpriteKit

class Dungeon: GameScene, Generation {
    
    var enemyCount = 0
    var rooms: [DungeonRoom] = []
    //Rooms to complete before boss fight
    var numOfRooms = 1
    private var enClear:Bool!
    private var itClear:Bool!
    private var room:DungeonRoom!
    private var seed:[Int] = []
    var location:CGPoint!
    private var roomType:Int!
    private var bkgImg:SKSpriteNode!
    private var direction: String!
    private var previous:String!
    private var door:Door?
    private var door2:Door?
    private var door3:Door?
    private var door4:Door?
    
    var tallWalls: SKSpriteNode!
    var tallBkg: SKSpriteNode!
    var smallWalls: SKSpriteNode!
    var smallBkg: SKSpriteNode!
    
    var clearCount = 0
    
    
    init(size: CGSize, player: Player, seed: [Int], direction: String, location: CGPoint, count: Int) {
        self.location = location
        self.direction = direction
        self.seed = seed
        self.clearCount = count
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateSeed(){
        if seed.count < 4 {
            seed.append(Int(arc4random_uniform(9) + 2))
            seed.append(3)
            seed.append(Int(arc4random_uniform(4) + 1))
            seed.append(Int(arc4random_uniform(9) + 2))
            
            clearCount = 0
        }
    }
    
    func incrememntLocation(){
        switch(direction){
        case "bottom":
            location.y += 1
            if location.y > 50{
                location.y -= 50
            }
            break
        case "top":
            location.y -= 1
            if location.y < 1{
                location.y += 50
            }
            break
        case "left":
            location.x += 1
            if location.x > 50{
                location.x -= 50
            }
            break
        case "right":
            location.x -= 1
            if location.x < 1{
                location.x += 50
            }
            break
        default: break
        }
    }
    
    func generateRoomType(){
        let locCalc = Int(location.x + location.y)
        if locCalc % self.seed[0] == 0{
            background = tallBkg
            bkgImg = tallWalls
            roomType = 0
            background.size = bkgImg.size
        }
        else{
            background = smallBkg
            bkgImg = smallWalls
            roomType = 1
        }
    }
    
    func initPlayerPosition(){
        switch(direction){
        case "bottom":
            player.position = CGPointMake(door!.position.x, door!.position.y + 100)
            break
        case "top":
            player.position = CGPointMake(door3!.position.x, door3!.position.y - 100)
            break
        case "left":
            player.position = CGPointMake(door2!.position.x + 100, door2!.position.y)
            break
        case "right":
            player.position = CGPointMake(door4!.position.x - 100, door4!.position.y)
            break
        default: break
        }
    }
    
    func enableDoors(){
        if enemyCount == 0{
            door?.enabled = true
            door2?.enabled = true
            door3?.enabled = true
            door4?.enabled = true
        }
    }
    
    func initEnemies(){
        var enemies: [Enemy] = []
        if !rooms.contains(room) || room.enemiesClear == false{
            clearCount += 1
            door?.enabled = false
            door2?.enabled = false
            door3?.enabled = false
            door4?.enabled = false
            
            var enemyLayout:Int! = 0
            enemyLayout = Int(abs(location.x - location.y)) / self.seed[3]
            while enemyLayout > 4{
                enemyLayout = enemyLayout / self.seed[2]
            }
            switch(enemyLayout){ //Enemy Configuration
            case 0:
                enemies.append(TestMelee(texture: nil, color: .whiteColor(), size: CGSizeMake(100, 100)))
                enemies.append(TestMelee(texture: nil, color: .whiteColor(), size: CGSizeMake(100, 100)))
                enemies.append(TestEnemy(texture: nil, color: .whiteColor(), size: CGSizeMake(100, 100)))
                break
            case 1:
                enemies.append(TestMelee(texture: nil, color: .whiteColor(), size: CGSizeMake(100, 100)))
                enemies.append(TestEnemy(texture: nil, color: .whiteColor(), size: CGSizeMake(100, 100)))
                enemies.append(TestEnemy(texture: nil, color: .whiteColor(), size: CGSizeMake(100, 100)))
                break
            case 2:
                enemies.append(TestEnemy(texture: nil, color: .whiteColor(), size: CGSizeMake(100, 100)))
                enemies.append(TestEnemy(texture: nil, color: .whiteColor(), size: CGSizeMake(100, 100)))
                enemies.append(TestEnemy(texture: nil, color: .whiteColor(), size: CGSizeMake(100, 100)))
                break
            case 3:
                enemies.append(TestMelee(texture: nil, color: .whiteColor(), size: CGSizeMake(100, 100)))
                enemies.append(TestMelee(texture: nil, color: .whiteColor(), size: CGSizeMake(100, 100)))
                enemies.append(TestMelee(texture: nil, color: .whiteColor(), size: CGSizeMake(100, 100)))
                break
            default:
                break
            }
            for enemy in enemies{
//                enemy.name = "enemy"
//                enemy.zPosition = 10
//                enemy.physicsBody?.collisionBitMask = PhysicsCategory.character
//                enemy.physicsBody?.categoryBitMask = PhysicsCategory.None
                self.addChild(enemy)
                enemyCount += 1
                enemy.position = CGPointMake(size.width/2, size.height/2)
                enumerateChildNodesWithName("scenery"){ node, _ in
                    let scenery = node as! Scenery
                    while CGRectIntersectsRect(enemy.frame, scenery.frame){
                        self.positionEnemy(enemy)
                    }
                }
                //prevent enemies from spawning inside one another
                enumerateChildNodesWithName("enemy"){ node, _ in
                    let en = node as! Enemy
                    if enemy != en{
                        while CGRectIntersectsRect(enemy.frame, en.frame){
                            self.positionEnemy(enemy)
                        }
                    }
                }
            }
        }
    }
    
    func positionEnemy(enemy:Enemy){
        let move = arc4random_uniform(4)
        switch(move){
        case 0:
            enemy.position.x += 100
            break
        case 1:
            enemy.position.x -= 100
            break
        case 2:
            enemy.position.y += 100
            break
        case 3:
            enemy.position.y -= 100
            break
        default: break
        }
    }
    
    func addDoors(){
        var doorLayout:Int! = 0
        doorLayout = Int(abs(location.x - location.y)) / self.seed[3]
        while doorLayout > 12{
            doorLayout = doorLayout / self.seed[3]
        }
        
        switch(doorLayout){ //Doors
        case 1, 10:
            blrt()
            break
        case 2:
            trb()
            break
        case 3:
            tlb()
            break
        case 4:
            blr()
            break
        case 5:
            tlr()
            break
        case 6:
            bl()
            break
        case 7:
            br()
            break
        case 8:
            bt()
            break
        case 9:
            tl()
            break
        case 11:
            tr()
            break
        case 12:
            rl()
            break
        default:
            blrt()
            break
        }
        checkSurroundingRooms()
    }
    
    func initDoors(){
        //Bottom door
        door = Door(texture: SKTexture(imageNamed: "caveTunnel"), color: UIColor.clearColor(), size: CGSizeMake(100, 100), level: Cave(size: size, player: player, seed: self.seed, direction: "top", location: location, count: clearCount))
        door!.position = CGPointMake(size.width/2, size.height/2 - bkgImg.size.height/2 + 50)
        door!.zPosition = 40
        door!.runAction(SKAction.rotateByAngle(CGFloat(M_PI), duration: 0))
        
        //Left door
        door2 = Door(texture: SKTexture(imageNamed: "caveTunnel"), color: UIColor.clearColor(), size: CGSizeMake(100, 100), level: Cave(size: size, player: player, seed: self.seed, direction: "right", location: location, count: clearCount))
        door2!.position = CGPointMake(bkgImg.size.width/2 - 225, size.height/2)
        door2!.zPosition = 40
        door2!.runAction(SKAction.rotateByAngle(CGFloat(M_PI/2), duration: 0))
        
        //Top door
        door3 = Door(texture: SKTexture(imageNamed: "caveTunnel"), color: UIColor.clearColor(), size: CGSizeMake(100, 100), level: Cave(size: size, player: player, seed: self.seed, direction: "bottom", location: location, count: clearCount))
        door3!.position = CGPointMake(size.width/2, size.height/2 + bkgImg.size.height/2 - 50)
        door3!.zPosition = 40
        
        //Right door
        door4 = Door(texture: SKTexture(imageNamed: "caveTunnel"), color: UIColor.clearColor(), size: CGSizeMake(100, 100), level: Cave(size: size, player: player, seed: self.seed, direction: "left", location: location, count: clearCount))
        door4!.position = CGPointMake(bkgImg.size.width + bkgImg.size.width/4, size.height/2)
        door4!.zPosition = 40
        door4!.runAction(SKAction.rotateByAngle(CGFloat(3 * M_PI/2), duration: 0))
    }
    
    func initItems(){
        let chest = Chest()
        chest.position = CGPointMake(size.width/2, size.height/2)
        enumerateChildNodesWithName("scenery"){ node, _ in
            let scenery = node as! Scenery
            while CGRectIntersectsRect(chest.frame, scenery.frame){
                let move = arc4random_uniform(4)
                switch(move){
                case 0:
                    chest.position.x += 100
                    break
                case 1:
                    chest.position.x -= 100
                    break
                case 2:
                    chest.position.y += 100
                    break
                case 3:
                    chest.position.y -= 100
                    break
                default: break
                }
            }
        }
        //prevent chest from spawning inside enemies
        enumerateChildNodesWithName("enemy"){ node, _ in
            let en = node as! Enemy
            if chest != en{
                while CGRectIntersectsRect(chest.frame, en.frame){
                    let move = arc4random_uniform(4)
                    switch(move){
                    case 0:
                        chest.position.x += 100
                        break
                    case 1:
                        chest.position.x -= 100
                        break
                    case 2:
                        chest.position.y += 100
                        break
                    case 3:
                        chest.position.y -= 100
                        break
                    default: break
                    }
                }
            }
        }
        chest.zPosition = 50
        addChild(chest)
    }
    
    func initBoss(){
        background = SKSpriteNode(imageNamed: "BossBkg")
        background.size = CGSizeMake(background.size.width, background.size.height - overlapAmount())
        bkgImg = SKSpriteNode(imageNamed: "BossWalls")
        bkgImg.size = CGSizeMake(bkgImg.size.width, bkgImg.size.height - overlapAmount())
        
        removeAllChildren()
        enemyCount = 0
        cameraNode.setScale(1.2)
        
        let boss = Boss()
        self.bossFight = true
        boss.position = CGPointMake(size.width/2, size.height/2)
        boss.zPosition = 10
        boss.name = "enemy"
//        player.position = CGPointMake(size.width/2, 200)
        addChild(boss)
    }
    
    func generateRoom(seed:[Int]){
        generateSeed()
        if location == CGPoint.zero{
            location = CGPointMake(CGFloat(arc4random_uniform(49) + 1), CGFloat(arc4random_uniform(49) + 1))
        }
        incrememntLocation()
        generateRoomType()
        generateInterior(roomType)
        initDoors()
        initPlayerPosition()
        initItems()
        
        enClear = enemyCount == 0 ? true : false
        itClear = enemyCount == 0 ? true : false
        room = DungeonRoom(location: location, enemiesClear: enClear, itemsClear: itClear)
        addDoors()
        
        switch(clearCount){
        case _ where clearCount >= numOfRooms && !rooms.contains(room):
            initBoss()
            break
        case _ where clearCount > 0:
            initEnemies()
            break
        default:
            clearCount += 1
            break
        }
//        if clearCount != 0{
//            initEnemies()
//        }
//        else{
//            clearCount += 1
//        }
        enableDoors()
        
//        if !rooms.contains(room) && clearCount == 1 {
//            initBoss()
//        }
        
//        if door?.parent == nil && door2?.parent == nil && door3?.parent == nil && door4?.parent == nil {
//            door?.loadLevel(self)
//        }
        
        background.position = CGPointMake(size.width/2, size.height/2)
        self.backgroundColor = UIColor.darkGrayColor()
        
        bkgImg.position = CGPointMake(size.width/2, size.height/2)
        bkgImg.physicsBody = SKPhysicsBody(texture: bkgImg.texture!, size: bkgImg.size)
        bkgImg.physicsBody?.affectedByGravity = false
        bkgImg.physicsBody?.allowsRotation = false
        bkgImg.physicsBody?.dynamic = false
        
        
//        player.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(100, 100))
//        
//        player.physicsBody?.affectedByGravity = false
//        player.physicsBody?.allowsRotation = false
//        player.physicsBody?.collisionBitMask = PhysicsCategory.character
//        player.physicsBody?.categoryBitMask = PhysicsCategory.None
        
        addChild(background)
        addChild(bkgImg)
        addChild(player)
        
    }
    
    func generateInterior(roomType: Int){
        let locCalc = Int(location.x + location.y)
        var interiorLayout = 0
        for i in 3.stride(through: 1, by: -1){
            if (locCalc + self.seed[1]) % i == 0{
                interiorLayout = i
                break
            }
        }
        if roomType == 0{
            if interiorLayout == 2{
                var columns:[Scenery] = []
                for i in 0...7{
                    columns.append(Scenery(texture: nil, color: .blackColor(), size: CGSizeMake(100, 100)))
                    columns[i].zPosition = 10
                    addChild(columns[i])
                }
                columns[0].position = CGPointMake(size.width/2 - 200, size.height/2 + 200)
                columns[1].position = CGPointMake(size.width/2 - 200, size.height/2 - 200)
                columns[2].position = CGPointMake(size.width/2 + 200, size.height/2 + 200)
                columns[3].position = CGPointMake(size.width/2 + 200, size.height/2 - 200)
                columns[4].position = CGPointMake(size.width/2 - 200, size.height/2 + 600)
                columns[5].position = CGPointMake(size.width/2 - 200, size.height/2 - 600)
                columns[6].position = CGPointMake(size.width/2 + 200, size.height/2 + 600)
                columns[7].position = CGPointMake(size.width/2 + 200, size.height/2 - 600)
            }
            else if interiorLayout == 3{
                let column = Scenery(texture: nil, color: .blackColor(), size: CGSizeMake(300, 900))
                column.position = CGPointMake(size.width/2, size.height/2)
                column.zPosition = 10
                addChild(column)
            }
        }
        else {
            if interiorLayout == 2{
                var columns:[Scenery] = []
                for i in 0...3{
                    columns.append(Scenery(texture: nil, color: .blackColor(), size: CGSizeMake(100, 100)))
                    columns[i].zPosition = 10
                    addChild(columns[i])
                }
                columns[0].position = CGPointMake(size.width/2 - 200, size.height/2 + 100)
                columns[1].position = CGPointMake(size.width/2 - 200, size.height/2 - 100)
                columns[2].position = CGPointMake(size.width/2 + 200, size.height/2 + 100)
                columns[3].position = CGPointMake(size.width/2 + 200, size.height/2 - 100)
            }
            else if interiorLayout == 3{
                let column = Scenery(texture: nil, color: .blackColor(), size: CGSizeMake(300, 300))
                column.position = CGPointMake(size.width/2, size.height/2)
                column.zPosition = 10
                addChild(column)
            }
        }
    }
    
    func calculateAdjacentDoors(locCalc:Int) -> [String]{
        var doorLayout:Int = 0
        
        doorLayout = Int(abs(location.x - location.y)) / self.seed[3]
        while doorLayout > 12{
            doorLayout = doorLayout / self.seed[3]
        }
        
        switch(doorLayout){ //Doors
        case 1, 10:
            return ["b","l","r","t"]
        case 2:
            return ["t","r","b"]
        case 3:
            return ["t","l","b"]
        case 4:
            return ["b","l","r"]
        case 5:
            return ["t","l","r"]
        case 6:
            return ["b","l"]
        case 7:
            return ["b","r"]
        case 8:
            return ["b","t"]
        case 9:
            return ["t","l"]
        case 11:
            return ["t","r"]
        case 12:
            return ["r","l"]
        default:
            return ["b","l","r","t"]
        }
    }
    
    func resetLocCalc(locCalc: Int) -> Int{
        return Int(location.x + location.y)
    }
    
    func checkSurroundingRooms(){
        let x = location.x
        let y = location.y
        location.x += 1
        if location.x > 50{
            location.x -= 50
        }
        
        var locCalc = Int(location.x + location.y)
        
        if !calculateAdjacentDoors(locCalc).contains("l"){
            door4?.removeFromParent()
        }
        
        location.x -= 2
        if location.x < 1{
            location.x += 50
        }
        
        locCalc = resetLocCalc(locCalc)
        
        if !calculateAdjacentDoors(locCalc).contains("r"){
            door2?.removeFromParent()
        }
        location.x = x
        
        location.y += 1
        if location.y > 50{
            location.y -= 50
        }
        
        locCalc = resetLocCalc(locCalc)
        
        if !calculateAdjacentDoors(locCalc).contains("b"){
            door3?.removeFromParent()
        }
        
        location.y -= 2
        if location.y < 1{
            location.y += 50
        }
        
        locCalc = resetLocCalc(locCalc)
        
        if !calculateAdjacentDoors(locCalc).contains("t"){
            door?.removeFromParent()
        }
        
        location.y = y
    }
    
    override func didMoveToView(view: SKView) {
        ui = UI(scene: self)
        
        camera = cameraNode
        generateRoom(seed)
        addChild(cameraNode)
        cameraNode.addChild(ui.ui)
        cameraNode.position = bkgImg.position
    }
    
    func blrt(){
        addChild(door!)
        addChild(door2!)
        addChild(door3!)
        addChild(door4!)
    }
    
    func trb(){
        addChild(door!)
        addChild(door3!)
        addChild(door4!)
    }
    
    func tlb(){
        addChild(door!)
        addChild(door2!)
        addChild(door3!)
    }
    
    func blr(){
        addChild(door!)
        addChild(door2!)
        addChild(door4!)
    }
    
    func tlr(){
        addChild(door2!)
        addChild(door3!)
        addChild(door4!)
    }
    
    func bl(){
        addChild(door!)
        addChild(door2!)
    }
    
    func br(){
        addChild(door!)
        addChild(door4!)
    }
    
    func bt(){
        addChild(door!)
        addChild(door3!)
    }
    
    func tl(){
        addChild(door2!)
        addChild(door3!)
    }
    
    func tr(){
        addChild(door3!)
        addChild(door4!)
    }
    
    func rl(){
        addChild(door2!)
        addChild(door4!)
    }
}
