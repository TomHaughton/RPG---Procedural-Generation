import SpriteKit
class Inventory {
    var capacity: Int
    var amountFilled: Int
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
    
    init(capacity:Int, amountFilled: Int){
        self.capacity = capacity
        self.amountFilled = amountFilled
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
    
    func setupInventoryUI(scene: GameScene, player: Player){
        inventory.removeAllChildren()
        inventory.size = CGSizeMake(scene.frame.width, scene.frame.height)
        inventory.zPosition = 100
        inventory.name = "inventory"
        
        invBack.size = CGSizeMake(scene.frame.width, scene.frame.height)
        invBack.color = UIColor.init(colorLiteralRed: 9, green: 150, blue: 152, alpha: 1)
        invBack.position = CGPointMake(0,0)
        invBack.anchorPoint = CGPointMake(0, 0)
        
        close.position = CGPointMake(0, 1150)
        close.anchorPoint = CGPointMake(0, 0)
        close.size = CGSizeMake(200, 200)
        close.color = UIColor.redColor()
        close.texture = SKTexture(imageNamed: "closeButton")
        
        head.size = CGSizeMake(200, 200)
        head.position = CGPointMake(400, scene.frame.height - 500)
        head.color = UIColor.brownColor()
        
        chest.size = CGSizeMake(200, 200)
        chest.position = CGPointMake(400 ,scene.frame.height - 750)
        chest.color = UIColor.brownColor()
        
        arms.size = CGSizeMake(200, 200)
        arms.position = CGPointMake(150, scene.frame.height - 750)
        arms.color = UIColor.brownColor()
        
        legs.size = CGSizeMake(200, 200)
        legs.position = CGPointMake(400, scene.frame.height - 1000)
        legs.color = UIColor.brownColor()
        
        weapon.size = CGSizeMake(200, 200)
        weapon.position = CGPointMake(650,scene.frame.height - 750)
        weapon.color = UIColor.brownColor()
        
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
        scene.ui.open.removeFromParent()
        scene.addChild(inventory)
    }
    
    func toggleInventory(scene: GameScene, touch: UITouch, player: Player){
        if scene.childNodeWithName("inventory") != nil && CGRectContainsPoint(close.frame, touch.locationInNode(inventory)){
            inventory.removeAllChildren()
            inventory.removeFromParent()
            scene.addChild(scene.ui.open)
        } else if CGRectContainsPoint(scene.ui.open.frame, touch.locationInNode(scene)){
            if scene.childNodeWithName("inventory") == nil{
                setupInventoryUI(scene, player: player)
            }
        }
    }

    func updateInventory(player: Player){
        if let _ = player.head{
            player.head?.removeFromParent()
            head = player.head!
            head.name = "worn"
        }
        if let _ = player.chest{
            player.chest?.removeFromParent()
            chest = player.chest!
            chest.name = "worn"
        }
        if let _ = player.legs{
            player.legs?.removeFromParent()
            legs = player.legs!
            legs.name = "worn"
        }
        if let _ = player.arms{
            player.arms?.removeFromParent()
            arms = player.arms!
            arms.name = "worn"
        }
        if let _ = player.weapon{
            player.weapon?.removeFromParent()
            weapon = player.weapon!
            weapon.name = "worn"
        }
        
        for index in 0...15{
            if index < player.inventory.items.count{
                slots[index] = player.inventory.items[index]
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