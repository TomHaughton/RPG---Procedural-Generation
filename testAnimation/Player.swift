import SpriteKit
import Foundation
class Player: SKSpriteNode {
    
    var maxHealth: Double = 100
    var health: Double = 100
    var defense: Double = 0
    var attack: Double = 0
    var attackSpeed: Double = 1
    var inventory = Inventory(capacity: 100, amountFilled:0)
    var level: Int = 1
    var xp: Int = 0
    var xpBoundary:Int!
    
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
        buildAnimations()
        zPosition = 2
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
                toEquip.size = CGSizeMake(65,50)
                toEquip.position = CGPointMake(0,40)
                toEquip.zPosition = 90
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
                break
            case ArmourSlot.Arms:
                if self.arms != nil {
                    defense -= self.arms!.defense
                    unequip(self.arms!)
                }
                self.arms = toEquip
                defense += toEquip.defense
                moveFromInvToPlayer(item, index: index)
                break
            case ArmourSlot.Legs:
                if self.legs != nil {
                    defense -= self.legs!.defense
                    unequip(self.legs!)
                }
                self.legs = toEquip
                defense += toEquip.defense
                moveFromInvToPlayer(item, index: index)
                break
            }
        } else if let toEquip = item as? Weapon{
            if self.weapon != nil {
                unequip(self.weapon!)
            }
            self.weapon = toEquip
            attack = toEquip.attack
            moveFromInvToPlayer(item, index: index)
            toEquip.size = CGSizeMake(70,70)
            toEquip.position = CGPointMake(55,10)
            toEquip.zPosition = 90
            toEquip.name = "weapon"
            addChild(toEquip.copy() as! Item)
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
        self.inventory.addItem(item)
    }
    
    func startAnimation(direction: String) {
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

    func move(touch: CGPoint, dpad: [SKSpriteNode], scene: GameScene){
        let moveWait = SKAction.runBlock(){
            self.removeActionForKey("move")
        }
        
        if actionForKey("move") == nil{
            if CGRectContainsPoint(dpad[0].frame, touch) {
                texture = SKTexture(imageNamed: "PlayerSpriteBack")
                if checkSurroundings(scene, x: 0, y: 100){
                    self.runAction(SKAction.sequence([SKAction.moveByX(0, y: 100, duration: 0.25), moveWait]), withKey: "move")
                    self.startAnimation("up")
                }
            }
            if CGRectContainsPoint(dpad[1].frame, touch) {
                texture = SKTexture(imageNamed: "PlayerSprite")
                if checkSurroundings(scene, x: 0, y: -100) {
                    self.runAction(SKAction.sequence([SKAction.moveByX(0, y: -100, duration: 0.25), moveWait]), withKey: "move")
                    self.startAnimation("down")
                }
            }
            if CGRectContainsPoint(dpad[2].frame, touch) {
                if checkSurroundings(scene, x: -100, y: 0){
                    self.runAction(SKAction.sequence([SKAction.moveByX(-100, y: 0, duration: 0.25), moveWait]), withKey: "move")
                    self.startAnimation("left")
                }
            }
            if CGRectContainsPoint(dpad[3].frame, touch) {
                if checkSurroundings(scene, x: 100, y: 0){
                    self.runAction(SKAction.sequence([SKAction.moveByX(100, y: 0, duration: 0.25), moveWait]), withKey: "move")
                    self.startAnimation("up")
                }
            }
        }
    }
    
    func damage(enemyAttack: Double){
        if defense == 0{
            health -= enemyAttack
        }
        else {
            health -= enemyAttack/defense
        }
    }
    
    func bleed(scene: GameScene){
        for _ in 0...arc4random_uniform(8){
            let blood = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(15, 15))
            blood.position = position
            blood.name = "blood"
            blood.zPosition = 0
            let x = CGFloat(arc4random_uniform(UInt32(200))) - 100
            let y = CGFloat(arc4random_uniform(UInt32(200))) - 100
            scene.addChild(blood)
            let remove = SKAction.runBlock(){
                blood.removeFromParent()
            }
            blood.runAction(SKAction.sequence([SKAction.moveByX(x, y: y, duration: 0.05), SKAction.waitForDuration(3),remove]))
        }
    }
    
    func doAttack(scene:GameScene){
        if self.actionForKey("attack") == nil {
            var enemies: [Enemy] = []
            scene.enumerateChildNodesWithName("enemy") { node, _ in
                let enemy = node as! Enemy
                
                if self.actionForKey("attack") == nil {
                    if CGRectContainsPoint(CGRectOffset(scene.player.frame, 100, 0), enemy.position){
                        enemies.append(enemy)
                    }
                    else if CGRectContainsPoint(CGRectOffset(scene.player.frame, -100, 0), enemy.position){
                        enemies.append(enemy)
                    }
                    else if CGRectContainsPoint(CGRectOffset(scene.player.frame, 0, 100), enemy.position){
                        enemies.append(enemy)
                    }
                    else if CGRectContainsPoint(CGRectOffset(scene.player.frame, 0, -100), enemy.position){
                        enemies.append(enemy)
                    }
                }
            }
            
            var run: [SKAction] = []
            for enemy in enemies{
                let attackAction = SKAction.runBlock(){
                    if enemy.defense == 0{
                        enemy.health = enemy.health - self.attack
                    }
                    else {
                        enemy.health = enemy.health - self.attack/enemy.defense
                    }
                    
                    if enemy.health <= 0 {
                        enemy.removeFromParent()
                        self.xp += enemy.xp
                        if self.xp >= self.xpBoundary{
                            self.maxHealth = self.maxHealth + Double(self.level * 10)
                            self.level += 1
                            self.xpBoundary = self.level * 200
                            self.xp = 0
                        }
                        scene.ui.xpBar.size = CGSizeMake(CGFloat(1500 / scene.player.xpBoundary) * CGFloat(scene.player.xp), 40)
                        scene.ui.healthBar.size = CGSizeMake(CGFloat(1500 / scene.player.maxHealth) * CGFloat(scene.player.health), 100)
                    }
                }
                let runAttack = SKAction.runBlock(){
                    if CGRectContainsPoint(CGRectOffset(scene.player.frame, 100, 0), enemy.position){
                        self.runAction(attackAction)
                        if enemy.checkSurroundings(scene, x: 100, y: 0){
                            enemy.runAction(SKAction.moveByX(100, y: 0, duration: 0.05))
                        }
                    }
                    else if CGRectContainsPoint(CGRectOffset(scene.player.frame, -100, 0), enemy.position){
                        self.runAction(attackAction)
                        if enemy.checkSurroundings(scene, x: -100, y: 0){
                            enemy.runAction(SKAction.moveByX(-100, y: 0, duration: 0.05))
                        }
                    }
                    else if CGRectContainsPoint(CGRectOffset(scene.player.frame, 0, 100), enemy.position){
                        self.runAction(attackAction)
                        if enemy.checkSurroundings(scene, x: 0, y: 100){
                            enemy.runAction(SKAction.moveByX(0, y: 100, duration: 0.05))
                        }
                    }
                    else if CGRectContainsPoint(CGRectOffset(scene.player.frame, 0, -100), enemy.position){
                        self.runAction(attackAction)
                        if enemy.checkSurroundings(scene, x: 0, y: -100){
                            enemy.runAction(SKAction.moveByX(0, y: -100, duration: 0.05))
                        }
                    }
                    else if CGRectContainsPoint(scene.player.frame, enemy.position){
                        self.runAction(attackAction)
                        if enemy.checkSurroundings(scene, x: 0, y: -100){
                            enemy.runAction(SKAction.moveByX(0, y: -100, duration: 0.05))
                        }
                    }
                    else {
                        self.removeActionForKey("attack")
                    }
                }
                run.append(runAttack)
            }
            
            let attackWait = SKAction.runBlock(){
                self.removeActionForKey("attack")
            }
            
            let attackWithCoolDown = SKAction.runBlock(){
                for action in run{
                    self.runAction(action)
                }
            }
            runAction(SKAction.sequence([attackWithCoolDown, SKAction.waitForDuration(self.attackSpeed), attackWait]), withKey: "attack")
        }
    }
    
    func checkSurroundings(scene: GameScene, x: CGFloat, y:CGFloat) -> Bool{
        var canMove = false
        
        scene.enumerateChildNodesWithName("door") { node, _ in
            let door = node as! Door
            if door.containsPoint(CGPointMake(self.position.x + x, self.position.y + y)){
                door.loadLevel(scene)
                canMove = true
            }
        }
        
        scene.enumerateChildNodesWithName("scenery") { node, _ in
            let scenery = node as! Scenery
            if !scenery.containsPoint(CGPointMake(self.position.x + x, self.position.y + y)){
                canMove = true            }
            else {
                canMove = false
            }
        }
        return canMove
    }
}
