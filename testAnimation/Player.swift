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
    var gameMode: Character = "D"
    
    var attackWait: SKAction!
    
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
    var playerAnimationSlash:SKAction!
    
    init(){
        super.init(texture: SKTexture(imageNamed:"PlayerSprite"), color: .clearColor(), size: CGSizeMake(100, 100))
        
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(100, 100))
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.dynamic = true
        physicsBody?.collisionBitMask = PhysicsCategory.character
        physicsBody?.categoryBitMask = PhysicsCategory.None
        buildAnimations()
        zPosition = 100
        xpBoundary = level * 100 * 2
        attackWait = SKAction.runBlock(){
            self.removeActionForKey("attack")
        }
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
                    enumerateChildNodesWithName("helmet"){ node, _ in
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
                toEquip.name = "helmet"
                break
            case ArmourSlot.Chest:
                if self.chest != nil {
                    defense -= self.chest!.defense
                    unequip(self.chest!)
                }
                self.chest = toEquip
                toEquip.name = "chest"
                break
            case ArmourSlot.Arms:
                if self.arms != nil {
                    defense -= self.arms!.defense
                    unequip(self.arms!)
                }
                self.arms = toEquip
                toEquip.name = "arms"
                break
            case ArmourSlot.Legs:
                if self.legs != nil {
                    defense -= self.legs!.defense
                    unequip(self.legs!)
                }
                self.legs = toEquip
                toEquip.name = "legs"
                break
            }
            toEquip.size = CGSizeMake(100,100)
            toEquip.position = CGPointMake(0,0)
            defense += toEquip.defense
            moveFromInvToPlayer(item, index: index)
            addChild(toEquip.copy() as! Item)
        } else if let toEquip = item as? Weapon{
            if self.weapon != nil {
                unequip(self.weapon!)
            }
            self.weapon = toEquip
            attack = toEquip.attack
            moveFromInvToPlayer(item, index: index)
            toEquip.size = CGSizeMake(100,100)
            toEquip.position = CGPointMake(0,0)
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
        var texturesSlash:[SKTexture] = []
        texturesSlash.append(SKTexture(imageNamed: "slash1"))
        texturesSlash.append(SKTexture(imageNamed: "slash2"))
        texturesSlash.append(SKTexture(imageNamed: "slash3"))
        texturesSlash.append(SKTexture(imageNamed: "slash4"))
        texturesSlash.append(SKTexture(imageNamed: "slash5"))
        texturesSlash.append(SKTexture(imageNamed: "slash6"))
        playerAnimationDown = SKAction.animateWithTextures(texturesDown, timePerFrame: 0.2)
        playerAnimationUp = SKAction.animateWithTextures(texturesUp, timePerFrame: 0.2)
        playerAnimationLeft = SKAction.animateWithTextures(texturesLeft, timePerFrame: 0.2)
        playerAnimationRight = SKAction.animateWithTextures(texturesRight, timePerFrame: 0.2)
        playerAnimationSlash = SKAction.animateWithTextures(texturesSlash, timePerFrame: 0.03)
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
            
            checkSurroundings(scene)
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
        blink()
    }
    
    func blink(){
        let fade = SKAction.runBlock(){
            self.alpha = 0.5
        }
        let unfade = SKAction.runBlock(){
            self.alpha = 1
        }
        let wait = SKAction.runBlock(){
            SKAction.waitForDuration(0.1)
        }
        runAction(SKAction.sequence([fade,wait,unfade]))
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
            blood.runAction(SKAction.sequence([SKAction.moveByX(x, y: y, duration: 0.1), SKAction.waitForDuration(1.5),remove]))
        }
    }
    
    func doAttack(scene: GameScene, touch: UITouch){
        if CGRectContainsPoint(scene.ui.attackStick.frame, touch.locationInNode(scene.ui.ui)){
            scene.ui.innerAttackStick.position = touch.locationInNode(scene.ui.attackStick)
        }
        if self.actionForKey("attack") == nil {
            if let weapon = scene.player.weapon{
                if CGRectContainsPoint(scene.ui.attackStick.frame, touch.locationInNode(scene.ui.ui)) {
                    if weapon.isKindOfClass(RangedWeapon){
                        rangedAttack(scene, touch: touch)
                    }
                    else {
                        meleeAttack(scene, touch: touch)
                    }
                }
            }
        }
    }
    
    func meleeAttack(scene:GameScene, touch: UITouch){
        let slash = SKAction.runBlock(){
            var direction = CGPointMake(0, 0) + touch.locationInNode(scene.ui.attackStick)
            direction = direction / velocityMag(direction) * 100
            
            scene.enumerateChildNodesWithName("enemy"){ node, _ in
                let enemy = node as! Enemy
                if CGRectContainsPoint(enemy.frame, self.position + direction){
                    enemy.takeDamage(scene, attack: self.attack)
                    self.checkQuests(enemy, scene: scene)
                }
            }
        }
        let animSprite = SKSpriteNode(color: .clearColor(), size: CGSizeMake(150, 150))
        let addAnimation = SKAction.runBlock(){
            self.addChild(animSprite)
        }
        let animate = SKAction.runBlock(){
            animSprite.runAction(self.playerAnimationSlash)
        }
        let removeAnimation = SKAction.runBlock(){
            animSprite.removeFromParent()
        }
        let slashGroup = SKAction.group([slash,animate])
        runAction(SKAction.sequence([addAnimation,slashGroup,SKAction.waitForDuration(0.24),removeAnimation,SKAction.waitForDuration(weapon!.attackSpeed - 0.18),attackWait]),withKey: "attack")
    }
    
    func rangedAttack(scene:GameScene, touch: UITouch){
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
        runAction(SKAction.sequence([shoot,SKAction.waitForDuration(weapon!.attackSpeed),attackWait]),withKey: "attack")
    }
    
    func checkQuests(enemy:Enemy, scene: GameScene){
        if enemy.health <= 0{
            for quest in self.questLog{
                quest.checkProgress(enemy, player: self)
            }
            self.xp += enemy.xp
            if self.xp >= self.xpBoundary{
                levelUp()
            }
            scene.ui.xpBar.size = CGSizeMake(CGFloat(1500 / self.xpBoundary) * CGFloat(self.xp), 40)
            if !(self.health <= 0){
                scene.ui.healthBar.size = CGSizeMake(CGFloat(1500 / self.maxHealth) * CGFloat(self.health), 100)
            }
        }
    }
    
    func levelUp(){
        maxHealth = self.maxHealth + Double(level * 10)
        level += 1
        xpBoundary = level * 200
        xp = 0
    }
    
    func checkChests(scene:GameScene) -> Bool{
        var ret = true
        scene.enumerateChildNodesWithName("chest") { node, _ in
            let chest = node as! Chest
            
            if CGRectIntersectsRect(chest.frame, self.frame.offsetBy(dx: self.velocity.x, dy: self.velocity.y)){
                chest.openChest()
                ret = false
            }
        }
        return ret
    }
    
    func checkDoors(scene:GameScene) -> Bool{
        var ret = true
        scene.enumerateChildNodesWithName("door") { node, _ in
            let door = node as! Door
            
            if CGRectIntersectsRect(door.frame, self.frame.offsetBy(dx: self.velocity.x, dy: self.velocity.y)){
                door.loadLevel(scene)
                ret = false
            }
        }
        return ret
    }
    
    func checkScenery(scene:GameScene) -> Bool{
        var ret = true
        scene.enumerateChildNodesWithName("scenery") { node, _ in
            let scenery = node as! Scenery
            if scenery.containsPoint(CGPointMake(self.position.x + self.velocity.x, self.position.y + self.velocity.y)){
                ret = false
            }
        }
        return ret
    }
    
    func checkNpcs(scene:GameScene){
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
    }
    
    func checkSurroundings(scene: GameScene) -> Bool{
        var canMove = true
        
        canMove = checkChests(scene)
        canMove = checkDoors(scene)
        canMove = checkScenery(scene)
        checkNpcs(scene)
        return canMove
    }
}
