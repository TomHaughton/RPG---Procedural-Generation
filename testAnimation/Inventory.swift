import SpriteKit
class Inventory {
    var capacity: Int
    var amountFilled: Int = 0
    var items = Array<Item>()
    var inventory = SKSpriteNode()
    let close = SKSpriteNode()
    var head = SKSpriteNode()
    var chest = SKSpriteNode()
    var arms = SKSpriteNode()
    var legs = SKSpriteNode()
    var weapon = SKSpriteNode()
    var slots:[SKSpriteNode] = []
    var invBack = SKSpriteNode()
    var bkg: [SKSpriteNode] = []
    
    var level = SKLabelNode()
    var health = SKLabelNode()
    var attack = SKLabelNode()
    var defense = SKLabelNode()
    
    init(capacity:Int){
        self.capacity = capacity
    }
    
    func addItem(item: Item) -> Bool{
        if (amountFilled + item.weight) < capacity {
            amountFilled += item.weight
            items.append(item)
            return true
        }
        return false
    }
    
    func getItem(index: Int) -> Item?{
        return items[index]
    }
    
    func remove(item:Item){
        for index in 0...items.count{
            if item == items[index]{
                items.removeAtIndex(index)
            }
        }
    }
    
    func setupInventoryUI(scene: GameScene, player: Player){
        inventory.removeAllChildren()
        inventory.size = CGSizeMake(scene.frame.width, scene.frame.height)
        inventory.zPosition = 100
        inventory.name = "inventory"
        
        invBack.size = CGSizeMake(scene.frame.width, scene.frame.height)
//        invBack.color = UIColor.init(colorLiteralRed: 9, green: 150, blue: 152, alpha: 1)
        invBack.texture = SKTexture(imageNamed: "invBkg")
        invBack.position = CGPointMake(0,0)
        invBack.anchorPoint = CGPointMake(0, 0)
        
        let topMargin = scene.overlapAmount() < 100 ? 400 : scene.overlapAmount()
        
        close.position = CGPointMake(0, scene.size.height - (scene.overlapAmount() / 2) - 200)
        close.anchorPoint = CGPointMake(0, 0)
        close.size = CGSizeMake(200, 200)
        close.color = UIColor.redColor()
        close.texture = SKTexture(imageNamed: "closeButton")
        
        head.size = CGSizeMake(200, 200)
        head.position = CGPointMake(400, scene.frame.height - topMargin)
        head.color = UIColor.brownColor()
        
        chest.size = CGSizeMake(200, 200)
        chest.position = CGPointMake(400 ,scene.frame.height - topMargin - 250)
        chest.color = UIColor.brownColor()
        
        arms.size = CGSizeMake(200, 200)
        arms.position = CGPointMake(150, scene.frame.height - topMargin - 250)
        arms.color = UIColor.brownColor()
        
        legs.size = CGSizeMake(200, 200)
        legs.position = CGPointMake(400, scene.frame.height - topMargin - 500)
        legs.color = UIColor.brownColor()
        
        weapon.size = CGSizeMake(200, 200)
        weapon.position = CGPointMake(650,scene.frame.height - topMargin - 250)
        weapon.color = UIColor.brownColor()
        
        level.fontSize = 80
        level.fontName = "Cochin"
        level.fontColor = UIColor.whiteColor()
        level.text = "Lvl: \(player.level)"
        level.position = CGPointMake(700, scene.frame.height - topMargin)
        
        health.fontSize = 80
        health.fontName = "Cochin"
        health.fontColor = UIColor.whiteColor()
        health.text = "Health: \(player.health)"
        health.position = CGPointMake(250, scene.frame.height - topMargin - 700)
        
        attack.fontSize = 80
        attack.fontName = "Cochin"
        attack.fontColor = UIColor.whiteColor()
        attack.text = "Attack: \(player.attack)"
        attack.position = CGPointMake(250, scene.frame.height - topMargin - 800)
        
        defense.fontSize = 80
        defense.fontName = "Cochin"
        defense.fontColor = UIColor.whiteColor()
        defense.text = "Defense: \(player.defense)"
        defense.position = CGPointMake(250, scene.frame.height - topMargin - 900)
        
        var x = CGFloat(scene.frame.width - 1000)
        var y = CGFloat(scene.frame.height - 400)
        slots = [SKSpriteNode]()
        bkg = [SKSpriteNode]()
        for index in 0...15{
            let itemBkg = SKSpriteNode()
            itemBkg.color = UIColor.brownColor()
            itemBkg.position = CGPointMake(x, y)
            itemBkg.size = CGSizeMake(200, 200)
            itemBkg.zPosition = 101
            itemBkg.alpha = 0.5
            
            var slot = Item()
            
            if index < player.inventory.items.count{
                slot = player.inventory.items[index]
                slot.removeFromParent()
                slot.position = CGPointMake(x, y)
                slot.size = CGSizeMake(200, 200)
                slot.zPosition = 102
                slot.name = "slot"
            }
            y -= 250
            if y <= 200 {
                y = CGFloat(scene.frame.height - 400)
                x += 250
            }
            bkg.append(itemBkg)
            slots.append(slot)
            inventory.addChild(itemBkg)
            inventory.addChild(slot)
        }
        
        inventory.removeFromParent()
        inventory.addChild(invBack)
        inventory.addChild(close)
        inventory.addChild(head)
        inventory.addChild(chest)
        inventory.addChild(arms)
        inventory.addChild(legs)
        inventory.addChild(weapon)
        inventory.addChild(level)
        inventory.addChild(health)
        inventory.addChild(attack)
        inventory.addChild(defense)
        close.zPosition = 100
        scene.ui.ui.addChild(inventory)
    }
    
    func toggleInventory(scene: GameScene, touch: CGPoint, player: Player){
        if scene.pause {
            scene.pause = false
        }
        else {
            scene.pause = true
        }
        if scene.ui.ui.childNodeWithName("inventory") != nil && CGRectContainsPoint(close.frame, touch){
            inventory.removeAllChildren()
            inventory.removeFromParent()
        } else if CGRectContainsPoint(scene.ui.open.frame, touch){
            if scene.childNodeWithName("inventory") == nil{
                setupInventoryUI(scene, player: player)
            }
        }
    }

    func updateInventory(player: Player){
        head.texture = player.head?.texture
        arms.texture = player.arms?.texture
        legs.texture = player.legs?.texture
        weapon.texture = player.weapon?.texture
        chest.texture = player.chest?.texture
        
        for index in 0...15{
            if index < player.inventory.items.count {
                slots[index] = player.inventory.items[index]
                slots[index].texture = player.inventory.items[index].texture
            }
            else{
                slots[index].texture = nil
                slots[index] = SKSpriteNode()
            }
        }
    }
    
    func checkEquip(touch: UITouch, player: Player){
        var nodes:[Item] = []
        inventory.enumerateChildNodesWithName("slot"){ node, _ in
            let item = node as! Item
            nodes.append(item)
        }
        if nodes.count != 0 {
            for i in 0...nodes.count - 1{
                if nodes[i].frame.contains(touch.locationInNode(self.inventory)){
                    for j in items{
                        if j === nodes[i]{
                            player.equip(nodes[i], index: i)
                        }
                    }
                }
            }
        }
    }
}
