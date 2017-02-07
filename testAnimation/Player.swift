import SpriteKit
import Foundation
class Player: SKSpriteNode {
    
    struct PhysicsCategory {
        static let None : UInt32 = 0
        static let All : UInt32 = UInt32.max
        static let character : UInt32 = 0b1
    }
    
    var maxHealth: Double = 100
    var health: Double = 100
    var defense: Double = 0
    var attack: Double = 0
    var attackSpeed: Double = 1
    var moveSpeed:CGFloat = 300
    var animDirection: String = ""
    var velocity = CGPoint.zero
    var inventory = Inventory(capacity: 16)
    var level: Int = 1
    var xp: Int = 0
    var xpBoundary:Int!
    var questLog:[Quest] = []
    
    //Armour/Weapon slots
    var head: Armour?
    var chest: Armour?
    var arms: Armour?
    var legs: Armour?
    var weapon: Weapon?
    var playerAnimationUp:SKAction!
    var playerAnimationDown:SKAction!
    var playerAnimationLeft:SKAction!
    var playerAnimationRight:SKAction!
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(100, 100))
        
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.dynamic = true
        physicsBody?.collisionBitMask = PhysicsCategory.character
        physicsBody?.categoryBitMask = PhysicsCategory.None
        buildAnimations()
        zPosition = 100
        xpBoundary = level * 100 * 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func unequip(item: Item) {
        if let toUnequip = item as? Armour{
            switch toUnequip.armourSlot! {
            case ArmourSlot.Head:
                if moveFromPlayerToInv(item){
                    self.head = nil
                    defense -= toUnequip.defense
                    enumerateChildNodesWithName("head"){ node, _ in
                        let item = node
                        item.removeFromParent()
                    }
                }
                break
            case ArmourSlot.Chest:
                if moveFromPlayerToInv(item){
                    self.chest = nil
                    defense -= toUnequip.defense
                }
                break
            case ArmourSlot.Arms:
                if moveFromPlayerToInv(item){
                    self.arms = nil
                    defense -= toUnequip.defense
                }
                break
            case ArmourSlot.Legs:
                if moveFromPlayerToInv(item){
                    self.legs = nil
                    defense -= toUnequip.defense
                }
                break
            }
        } else if let toUnequip = item as? Weapon{
            if moveFromPlayerToInv(item){
                self.weapon = nil
                attack -= toUnequip.attack
                enumerateChildNodesWithName("weapon"){ node, _ in
                    let item = node
                    item.removeFromParent()
                }
            }
        }
        inventory.updateInventory(self)
    }
    
    func equip(item: Item, index: Int) {
        if let toEquip = item as? Armour{
            switch toEquip.armourSlot! {
            case ArmourSlot.Head:
                if self.head != nil {
                    defense -= self.head!.defense
                    unequip(self.head!)
                }
                self.head = toEquip
                defense += toEquip.defense
                moveFromInvToPlayer(item, index: index)
                toEquip.size = CGSizeMake(100,100)
                toEquip.position = CGPointMake(0,0)
                toEquip.name = "helmet"
                addChild(toEquip.copy() as! Item)
                break
            case ArmourSlot.Chest:
                if self.chest != nil {
                    defense -= self.chest!.defense
                    unequip(self.chest!)
                }
                self.chest = toEquip
                defense += toEquip.defense
                moveFromInvToPlayer(item, index: index)
                toEquip.size = CGSizeMake(100,100)
                toEquip.position = CGPointMake(0,0)
                toEquip.name = "chest"
                addChild(toEquip.copy() as! Item)
                break
            case ArmourSlot.Arms:
                if self.arms != nil {
                    defense -= self.arms!.defense
                    unequip(self.arms!)
                }
                self.arms = toEquip
                defense += toEquip.defense
                moveFromInvToPlayer(item, index: index)
                toEquip.size = CGSizeMake(100,100)
                toEquip.position = CGPointMake(0,0)
                toEquip.name = "arms"
                addChild(toEquip.copy() as! Item)
                break
            case ArmourSlot.Legs:
                if self.legs != nil {
                    defense -= self.legs!.defense
                    unequip(self.legs!)
                }
                self.legs = toEquip
                defense += toEquip.defense
                moveFromInvToPlayer(item, index: index)
                toEquip.size = CGSizeMake(100,100)
                toEquip.position = CGPointMake(0,0)
                toEquip.name = "legs"
                addChild(toEquip.copy() as! Item)
                break
            }
        } else if let toEquip = item as? Weapon{
            if self.weapon != nil {
                unequip(self.weapon!)
            }
            self.weapon = toEquip
            attack = toEquip.attack
            moveFromInvToPlayer(item, index: index)
            toEquip.size = CGSizeMake(60,60)
            toEquip.position = CGPointMake(48,10)
            toEquip.name = "weapon"
            addChild(toEquip.copy() as! Item)
        }
        else if let toUse = item as? HealthPotion{
            toUse.use(self, index: index)
        }
        inventory.updateInventory(self)
    }
    
    func moveFromInvToPlayer(item: Item, index: Int) {
            inventory.amountFilled -= inventory.items[index].weight
            inventory.items.removeAtIndex(index)
    }
    
    func moveFromPlayerToInv(item: Item) -> Bool{
        return inventory.addItem(item)
    }
    
    func pickUp(item:Item){
        inventory.addItem(item)
        for quest in questLog{
            quest.checkProgress(item, player: self)
        }
    }
    
    func startAnimation(direction: String) {
        if animDirection != direction{
            removeActionForKey("animation")
        }
        animDirection = direction
        switch(direction){
        case "down":
            if self.actionForKey("animation") == nil {
                self.runAction(
                    SKAction.repeatActionForever(playerAnimationDown),
                    withKey: "animation")
            }
            break
        case "up":
            if self.actionForKey("animation") == nil {
                self.runAction(
                    SKAction.repeatActionForever(playerAnimationUp),
                    withKey: "animation")
            }
            break
        case "left":
            if self.actionForKey("animation") == nil {
                self.runAction(
                    SKAction.repeatActionForever(playerAnimationDown),
                    withKey: "animation")
            }
            break
        case "right":
            if self.actionForKey("animation") == nil {
                self.runAction(
                    SKAction.repeatActionForever(playerAnimationDown),
                    withKey: "animation")
            }
            break
        default:
            break
        }
    }
    
    func buildAnimations(){
        var texturesDown:[SKTexture] = []
        texturesDown.append(SKTexture(imageNamed: "PlayerSprite1"))
        texturesDown.append(SKTexture(imageNamed: "PlayerSprite2"))
        var texturesUp:[SKTexture] = []
        texturesUp.append(SKTexture(imageNamed: "PlayerSprite1Back"))
        texturesUp.append(SKTexture(imageNamed: "PlayerSprite2Back"))
        var texturesLeft:[SKTexture] = []
        texturesLeft.append(SKTexture(imageNamed: "PlayerSprite1"))
        texturesLeft.append(SKTexture(imageNamed: "PlayerSprite2"))
        var texturesRight:[SKTexture] = []
        texturesRight.append(SKTexture(imageNamed: "PlayerSprite1"))
        texturesRight.append(SKTexture(imageNamed: "PlayerSprite2"))
        playerAnimationDown = SKAction.animateWithTextures(texturesDown, timePerFrame: 0.2)
        playerAnimationUp = SKAction.animateWithTextures(texturesUp, timePerFrame: 0.2)
        playerAnimationLeft = SKAction.animateWithTextures(texturesLeft, timePerFrame: 0.2)
        playerAnimationRight = SKAction.animateWithTextures(texturesRight, timePerFrame: 0.2)
    }
    
    func move(touch: UITouch, scene: GameScene){
        //Keep analogue dead zone????????
        if CGRectContainsPoint(scene.ui.moveStick.frame, touch.locationInNode(scene.ui.ui)){
            scene.ui.innerMoveStick.position = touch.locationInNode(scene.ui.moveStick)
        }
        if CGRectContainsPoint(scene.ui.moveStick.frame, touch.locationInNode(scene.ui.ui))
            && distance(scene.ui.moveStick.position,right: touch.locationInNode(scene.ui.ui)) > 20 {
            velocity = CGPointMake(0, 0) - touch.locationInNode(scene.ui.moveStick)
            velocity = velocity / velocityMag(velocity) * moveSpeed
            velocity = velocity * CGFloat(scene.dt) * -1
            
            if abs(velocity.x) > abs(velocity.y){
                if velocity.x > 0{
                    self.startAnimation("right")
                }
                else {
                    self.startAnimation("left")
                }
            }
            else{
                if velocity.y > 0{
                    self.startAnimation("up")
                }
                else {
                    self.startAnimation("down")
                }
            }
            
            checkSurroundings(scene, x: position.x + velocity.x, y: position.y + velocity.y)
            position += velocity
        }
    }
    
    func damage(enemyAttack: Double){
        if defense == 0{
            health -= round(enemyAttack)
        }
        else {
            health -= round(enemyAttack/defense)
        }
    }
    
    func bleed(scene: GameScene){
        for _ in 0...arc4random_uniform(4){
            let blood = SKShapeNode(circleOfRadius: 7)
            blood.fillColor = .redColor()
            blood.strokeColor = .clearColor()
            blood.position = position
            blood.name = "blood"
            let x = CGFloat(arc4random_uniform(UInt32(150))) - 75
            let y = CGFloat(arc4random_uniform(UInt32(150))) - 75
            scene.addChild(blood)
            let remove = SKAction.runBlock(){
                blood.removeFromParent()
            }
            blood.runAction(SKAction.sequence([SKAction.moveByX(x, y: y, duration: 0.05), SKAction.waitForDuration(1.5),remove]))
        }
    }
    
    func doAttack(scene: GameScene, touch: UITouch){
        if CGRectContainsPoint(scene.ui.attackStick.frame, touch.locationInNode(scene.ui.ui)){
            scene.ui.innerAttackStick.position = touch.locationInNode(scene.ui.attackStick)
        }
        if self.actionForKey("attack") == nil {
            if let weapon = scene.player.weapon{
                let attackWait = SKAction.runBlock(){
                    self.removeActionForKey("attack")
                }
                if CGRectContainsPoint(scene.ui.attackStick.frame, touch.locationInNode(scene.ui.ui)) {
                    if weapon.isKindOfClass(RangedWeapon){
                        let shoot = SKAction.runBlock(){
                            let weap = self.weapon as! RangedWeapon
                            let projectile = Projectile(texture: weap.projTex, color: .redColor(), size: weap.projTex.size())
                            projectile.name = "projectile"
                            projectile.position = self.position
                            projectile.physicsBody = nil
                            projectile.zPosition = 40
                            projectile.speed = 500
                            projectile.friendly = true
                            projectile.attack = self.attack
                            
                            var vel = CGPointMake(0, 0) - touch.locationInNode(scene.ui.attackStick)
                            vel = vel / velocityMag(vel) * 500
                            projectile.velocity = vel
                            //Adapted from 2d tvios
                            projectile.zRotation = CGFloat(atan2(Double(vel.y), Double(vel.x))) + CGFloat(M_PI / 2)
                            //
                            scene.addChild(projectile)
                        }
                        runAction(SKAction.sequence([shoot,SKAction.waitForDuration(weapon.attackSpeed),attackWait]),withKey: "attack")
                    }
                    else {
                        let slash = SKAction.runBlock(){
                            var direction = CGPointMake(0, 0) + touch.locationInNode(scene.ui.attackStick)
                            direction = direction / velocityMag(direction) * 100
                            
                            scene.enumerateChildNodesWithName("enemy"){ node, _ in
                                let enemy = node as! Enemy
                                if CGRectContainsPoint(enemy.frame, self.position + direction){
                                    enemy.takeDamage(scene, attack: self.attack)
                                }
                            }
                        }
                        weapon.runAction(SKAction.sequence([SKAction.rotateByAngle(CGFloat(M_PI / 2.0), duration: 0.1),SKAction.rotateByAngle(CGFloat(M_PI / 2.0 * -1), duration: 0.1)]))
                        runAction(SKAction.sequence([slash,SKAction.waitForDuration(weapon.attackSpeed),attackWait]),withKey: "attack")
                    }
                }
            }
        }
    }
    
//    func doAttack(scene:GameScene){
//        if self.actionForKey("attack") == nil {
//            var enemies: [Enemy] = []
//            scene.enumerateChildNodesWithName("enemy") { node, _ in
//                let enemy = node as! Enemy
//                
//                if self.actionForKey("attack") == nil {
//                    if CGRectContainsPoint(CGRectOffset(scene.player.frame, 100, 0), enemy.position){
//                        enemies.append(enemy)
//                    }
//                    else if CGRectContainsPoint(CGRectOffset(scene.player.frame, -100, 0), enemy.position){
//                        enemies.append(enemy)
//                    }
//                    else if CGRectContainsPoint(CGRectOffset(scene.player.frame, 0, 100), enemy.position){
//                        enemies.append(enemy)
//                    }
//                    else if CGRectContainsPoint(CGRectOffset(scene.player.frame, 0, -100), enemy.position){
//                        enemies.append(enemy)
//                    }
//                }
//            }
//            
//            var run: [SKAction] = []
//            let attackSound = SKAction.playSoundFileNamed("SwordSwing.mp3", waitForCompletion: false)
//            for enemy in enemies{
//                let attackAction = SKAction.runBlock(){
//                    if enemy.defense == 0{
//                        self.runAction(attackSound)
//                        enemy.health = enemy.health - self.attack
//                    }
//                    else {
//                        self.runAction(attackSound)
//                        enemy.health = enemy.health - self.attack/enemy.defense
//                    }
//                    
//                    if enemy.health <= 0 {
//                        enemy.removeFromParent()
//                        if let room = scene as? Cave{
//                            room.enemyCount -= 1
//                            if room.enemyCount == 0{
//                                room.door?.enabled = true
//                                room.door2?.enabled = true
//                                room.door3?.enabled = true
//                                room.door4?.enabled = true
//                            }
//                        }
//                        enemy.drop(scene)
//                        for quest in self.questLog{
//                            quest.checkProgress(enemy, player: self)
//                        }
//                        self.xp += enemy.xp
//                        if self.xp >= self.xpBoundary{
//                            self.maxHealth = self.maxHealth + Double(self.level * 10)
//                            self.level += 1
//                            self.xpBoundary = self.level * 200
//                            self.xp = 0
//                        }
//                        scene.ui.xpBar.size = CGSizeMake(CGFloat(1500 / scene.player.xpBoundary) * CGFloat(scene.player.xp), 40)
//                        if !(self.health <= 0){
//                            scene.ui.healthBar.size = CGSizeMake(CGFloat(1500 / scene.player.maxHealth) * CGFloat(scene.player.health), 100)
//                        }
//                    }
//                }
//                let runAttack = SKAction.runBlock(){
//                    if CGRectContainsPoint(CGRectOffset(scene.player.frame, 100, 0), enemy.position){
//                        self.runAction(attackAction)
//                        if enemy.checkSurroundings(scene, x: 100, y: 0){
//                            enemy.runAction(SKAction.moveByX(100, y: 0, duration: 0.05))
//                        }
//                    }
//                    else if CGRectContainsPoint(CGRectOffset(scene.player.frame, -100, 0), enemy.position){
//                        self.runAction(attackAction)
//                        if enemy.checkSurroundings(scene, x: -100, y: 0){
//                            enemy.runAction(SKAction.moveByX(-100, y: 0, duration: 0.05))
//                        }
//                    }
//                    else if CGRectContainsPoint(CGRectOffset(scene.player.frame, 0, 100), enemy.position){
//                        self.runAction(attackAction)
//                        if enemy.checkSurroundings(scene, x: 0, y: 100){
//                            enemy.runAction(SKAction.moveByX(0, y: 100, duration: 0.05))
//                        }
//                    }
//                    else if CGRectContainsPoint(CGRectOffset(scene.player.frame, 0, -100), enemy.position){
//                        self.runAction(attackAction)
//                        if enemy.checkSurroundings(scene, x: 0, y: -100){
//                            enemy.runAction(SKAction.moveByX(0, y: -100, duration: 0.05))
//                        }
//                    }
//                    else if CGRectContainsPoint(scene.player.frame, enemy.position){
//                        self.runAction(attackAction)
//                        if enemy.checkSurroundings(scene, x: 0, y: -100){
//                            enemy.runAction(SKAction.moveByX(0, y: -100, duration: 0.05))
//                        }
//                    }
//                    else {
//                        self.removeActionForKey("attack")
//                    }
//                }
//                run.append(runAttack)
//            }
//            
//            let attackWait = SKAction.runBlock(){
//                self.removeActionForKey("attack")
//            }
//            
//            let attackWithCoolDown = SKAction.runBlock(){
//                for action in run{
//                    self.runAction(action)
//                }
//            }
//            runAction(SKAction.sequence([attackWithCoolDown, SKAction.waitForDuration(self.attackSpeed), attackWait]), withKey: "attack")
//        }
//    }
    
    func checkSurroundings(scene: GameScene, x: CGFloat, y:CGFloat) -> Bool{
        var canMove = true
        
        scene.enumerateChildNodesWithName("door") { node, _ in
            let door = node as! Door
            if CGRectContainsPoint(door.frame, self.position + self.velocity){
                
            }
            
            if CGRectIntersectsRect(door.frame, self.frame.offsetBy(dx: self.velocity.x, dy: self.velocity.y)){
                door.loadLevel(scene)
                canMove = false
            }
        }
        
        scene.enumerateChildNodesWithName("scenery") { node, _ in
            let scenery = node as! Scenery
            if scenery.containsPoint(CGPointMake(self.position.x + x, self.position.y + y)){
                canMove = false
            }
        }
        
        scene.enumerateChildNodesWithName("quest") { node, _ in
            let questGiver = node as! QuestGiver
            
            if CGRectIntersectsRect(questGiver.frame, self.frame.offsetBy(dx: self.velocity.x, dy: self.velocity.y)){
                if let quest = questGiver.quest{
                    if !self.questLog.contains(quest){
                        questGiver.showDialogue(scene)
                        questGiver.giveQuest(self)
                    }
                    else {
                        let qIndex = self.questLog.indexOf(quest)
                        if self.questLog[qIndex!].isComplete() || questGiver.quest == nil{
                            self.questLog[qIndex!].giveReward(scene.player)
                            questGiver.showThanks(scene)
                            self.questLog.removeAtIndex(qIndex!)
                            questGiver.quest = nil
                        }
                    }
                }
                else{
                    questGiver.showDialogue(scene)
                }
            }
        }
        return canMove
    }
}
