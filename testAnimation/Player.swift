import SpriteKit
import Foundation
class Player: SKSpriteNode {
    
    var health: Double = 100
    var defense: Double = 0
    var attack: Double = 0
    var attackSpeed: Double = 1
    var inventory = Inventory(capacity: 100, amountFilled:0)
    
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
        if actionForKey("move") == nil{
            if CGRectContainsPoint(dpad[0].frame, touch) && (position.y + 325 < scene.frame.height)  {
                texture = SKTexture(imageNamed: "PlayerSpriteBack")
                checkSurroundings(scene, x: 0, y: 100)
            }
            if CGRectContainsPoint(dpad[1].frame, touch) && (position.y - 50 > 100) {
                texture = SKTexture(imageNamed: "PlayerSprite")
                checkSurroundings(scene, x: 0, y: -100)
            }
            if CGRectContainsPoint(dpad[2].frame, touch) && (position.x - 50 > 50) {
                checkSurroundings(scene, x: -100, y: 0)
            }
            if CGRectContainsPoint(dpad[3].frame, touch) && (position.x + 100 < scene.frame.width) {
                checkSurroundings(scene, x: 100, y: 0)
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
            blood.zPosition = 1
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
        scene.enumerateChildNodesWithName("enemy") { node, _ in
            let enemy = node as! Enemy
            
            if self.actionForKey("attack") == nil {
                let attackWait = SKAction.runBlock(){
                    self.removeActionForKey("attack")
                }
                let attackAction = SKAction.runBlock(){
                    if enemy.defense == 0{
                        enemy.health = enemy.health - self.attack
                    }
                    else {
                        enemy.health = enemy.health - self.attack/enemy.defense
                    }
                
                    if enemy.health <= 0 {
                        enemy.removeFromParent()
                    }
                }
                
                if CGRectContainsPoint(CGRectOffset(scene.player.frame, 100, 0), enemy.position){
                    self.runAction(SKAction.sequence([attackAction, SKAction.waitForDuration(self.attackSpeed), attackWait]),withKey: "attack")
                    enemy.runAction(SKAction.moveByX(100, y: 0, duration: 0.05))
                }
                else if CGRectContainsPoint(CGRectOffset(scene.player.frame, -100, 0), enemy.position){
                    self.runAction(SKAction.sequence([attackAction, SKAction.waitForDuration(self.attackSpeed), attackWait]),withKey: "attack")
                    enemy.runAction(SKAction.moveByX(-100, y: 0, duration: 0.05))
                }
                else if CGRectContainsPoint(CGRectOffset(scene.player.frame, 0, 100), enemy.position){
                    self.runAction(SKAction.sequence([attackAction, SKAction.waitForDuration(self.attackSpeed), attackWait]),withKey: "attack")
                    enemy.runAction(SKAction.moveByX(0, y: 100, duration: 0.05))
                }
                else if CGRectContainsPoint(CGRectOffset(scene.player.frame, 0, -100), enemy.position){
                    self.runAction(SKAction.sequence([attackAction, SKAction.waitForDuration(self.attackSpeed), attackWait]),withKey: "attack")
                    enemy.runAction(SKAction.moveByX(0, y: -100, duration: 0.05))
                }
                else {
                    self.removeActionForKey("attack")
                }
            }
        }
    }
    
    func checkSurroundings(scene: GameScene, x: CGFloat, y:CGFloat){
        let moveWait = SKAction.runBlock(){
            self.removeActionForKey("move")
        }
        
        scene.enumerateChildNodesWithName("door") { node, _ in
            let door = node as! Door
            if door.containsPoint(CGPointMake(self.position.x + x, self.position.y + y)){
                door.loadLevel(scene)
            }
        }
        
        scene.enumerateChildNodesWithName("scenery") { node, _ in
            let scenery = node as! Scenery
            if !scenery.containsPoint(CGPointMake(self.position.x + x, self.position.y + y)){
                self.runAction(SKAction.sequence([SKAction.moveByX(x, y: y, duration: 0.25), moveWait]), withKey: "move")
                self.startAnimation("right")
            }
        }
    }
}