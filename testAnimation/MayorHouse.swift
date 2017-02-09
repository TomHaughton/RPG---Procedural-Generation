//
//  VillagerHouse.swift
//  testAnimation
//
//  Created by Thomas Haughton on 29/01/2017.
//  Copyright © 2017 Thomas Haughton. All rights reserved.
//

import Foundation
import SpriteKit

class MayorHouse:GameScene{
    init(size: CGSize, player: Player) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        ui = UI(scene: self)
        camera = cameraNode
        addChild(cameraNode)
        background = SKSpriteNode(imageNamed: "villagerFloor")
        background.position = CGPointMake(player.position.x, player.position.y + 250)
        self.backgroundColor = .darkGrayColor()
        
        let bkgImg = SKSpriteNode(imageNamed: "villagerWalls")
        bkgImg.position = CGPointMake(background.position.x, background.position.y)
        
        bkgImg.physicsBody = SKPhysicsBody(texture: bkgImg.texture!, size: background.size)
        bkgImg.physicsBody?.affectedByGravity = false
        bkgImg.physicsBody?.allowsRotation = false
        bkgImg.physicsBody?.dynamic = false
        
        //Interior
        let mayor = VillageMayor()
        let door = Door(texture: SKTexture(imageNamed: "VillageDoor"), color: .redColor(), size: CGSizeMake(100, 100), level: Level1(size: size, player: player))
        mayor.position = CGPointMake(bkgImg.position.x, bkgImg.position.y + 200)
        door.runAction(SKAction.rotateByAngle(CGFloat(M_PI), duration: 0))
        door.position = CGPointMake(bkgImg.position.x, bkgImg.position.y - 300)
        
        addChild(background)
        addChild(bkgImg)
        addChild(player)
        addChild(mayor)
        addChild(door)
        cameraNode.addChild(ui.ui)
    }
}
