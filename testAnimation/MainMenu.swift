//
//  MainMenu.swift
//  testAnimation
//
//  Created by Thomas Haughton on 29/01/2017.
//  Copyright © 2017 Thomas Haughton. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenu:SKScene{
    var btnRpg:SKSpriteNode!
    var btnDungeon:SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        btnRpg = SKSpriteNode(color: .blueColor(), size: CGSizeMake(800, 400))
        btnDungeon = SKSpriteNode(color: .blueColor(), size: CGSizeMake(800, 400))
        btnRpg.position = CGPointMake(size.width / 2, size.height / 2 + 300)
        btnDungeon.position = CGPointMake(size.width / 2, size.height / 2 - 300)
        let lblRpg = SKLabelNode(text: "Story Mode")
        let lblDungeon = SKLabelNode(text: "Dungeon Mode")
        lblRpg.fontName = "Cochin"
        lblDungeon.fontName = "Cochin"
        lblRpg.fontSize = 100
        lblDungeon.fontSize = 100
        
        btnRpg.addChild(lblRpg)
        btnDungeon.addChild(lblDungeon)
        
        addChild(btnRpg)
        addChild(btnDungeon)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if btnRpg.frame.contains((touches.first?.locationInNode(self))!){
            let scene = Level1(size:CGSize(width: 2048, height: 1536))
            scene.scaleMode = .AspectFill
            view?.presentScene(scene)
        }
        else if btnDungeon.frame.contains((touches.first?.locationInNode(self))!){
            let scene = Cave(size: CGSize(width: 2048, height: 1536), player: Player(), seed: [], direction: "bottom", location: CGPoint.zero, count: 0)
            scene.player = Player(imageNamed: "PlayerSprite")
            scene.player.pickUp(PlateHelmet())
            scene.player.pickUp(PlateArms())
            scene.player.pickUp(PlateChest())
            scene.player.pickUp(PlateLegs())
            scene.player.pickUp(TestSword())
            scene.player.pickUp(AutoRifle())
            scene.player.pickUp(Longbow())
            scene.player.pickUp(TestAxe())
            scene.player.pickUp(HealthPotion(texture: SKTexture(imageNamed:"HealthPotion"), color: .clearColor(), size: CGSizeMake(100, 100), health: 50))
            
            scene.scaleMode = .AspectFill
            view?.presentScene(scene)
        }
    }
}
