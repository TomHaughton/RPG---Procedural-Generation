//
//  Chest.swift
//  testAnimation
//
//  Created by Thomas Haughton on 07/02/2017.
//  Copyright © 2017 Thomas Haughton. All rights reserved.
//

import Foundation
import SpriteKit

class Chest:SKSpriteNode{
    var item: Item!
    var open = false
    
    init(){
        super.init(texture: SKTexture(imageNamed:"Chest"), color: .clearColor(), size: CGSizeMake(100, 100))
        name = "chest"
        initItem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func openChest(){
        self.texture = SKTexture(imageNamed: "ChestOpen")
        dropItem()
    }
    
    func dropItem(){
        if !open{
            if let _ = self.scene{
                item.position = self.position
                item.zPosition = 70
                self.scene?.addChild(item)
                open = true
            }
        }
    }
    
    func initItem(){
        var itemArray: NSArray?
        if let path = NSBundle.mainBundle().pathForResource("Items", ofType: "plist") {
            itemArray = NSArray(contentsOfFile: path)
        }
        if let arr = itemArray {
            let itemNum = Int(arc4random_uniform(UInt32(arr.count)))
            let itemName = "testAnimation." + String(arr[itemNum])
            let aClass = NSClassFromString(itemName) as! Item.Type
            item = aClass.init()
        }
    }
}
