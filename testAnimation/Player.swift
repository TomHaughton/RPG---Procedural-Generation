import SpriteKit
import Foundation
class Player: SKSpriteNode {
    
    var health: Int = 100
    var defense: Int = 0
    var attack: Int = 0
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
                attack -= self.weapon!.attack
                unequip(self.weapon!)
            }
            self.weapon = toEquip
            attack += toEquip.attack
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

    func move(touch: CGPoint, dpad: [SKSpriteNode], scene: CGRect){
        if actionForKey("move") == nil{
            let moveWait = SKAction.runBlock(){
                self.removeActionForKey("move")
            }
            if CGRectContainsPoint(dpad[0].frame, touch) && (position.y + 325 < scene.height)  {
                texture = SKTexture(imageNamed: "PlayerSpriteBack")
                runAction(SKAction.sequence([SKAction.moveByX(0, y: 100, duration: 0.25), moveWait]), withKey: "move")
                startAnimation("up")
            }
            if CGRectContainsPoint(dpad[1].frame, touch) && (position.y - 50 > 100) {
                texture = SKTexture(imageNamed: "PlayerSprite")
                runAction(SKAction.sequence([SKAction.moveByX(0, y: -100, duration: 0.25), moveWait]), withKey: "move")
                startAnimation("down")
            }
            if CGRectContainsPoint(dpad[2].frame, touch) && (position.x - 50 > 50) {
                runAction(SKAction.sequence([SKAction.moveByX(-100, y: 0, duration: 0.25), moveWait]), withKey: "move")
                startAnimation("left")
            }
            if CGRectContainsPoint(dpad[3].frame, touch) && (position.x + 100 < scene.width) {
                runAction(SKAction.sequence([SKAction.moveByX(100, y: 0, duration: 0.25), moveWait]), withKey: "move")
                startAnimation("right")
            }
        }
    }
}