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
    private var btnRpg:SKSpriteNode!
    private var btnDungeon:SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        let background = SKSpriteNode(imageNamed: "MainMenu")
        background.position = CGPointMake(size.width / 2, size.height / 2)
        btnRpg = SKSpriteNode(imageNamed: "StoryBtn")
        btnDungeon = SKSpriteNode(imageNamed: "DungeonBtn")
        btnRpg.position = CGPointMake(size.width / 2, size.height / 2 + 150)
        btnDungeon.position = CGPointMake(size.width / 2, size.height / 2 - 300)
        
        addChild(background)
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
            scene.player = Player()
            scene.player.gameMode = "D"
            scene.player.pickUp(PlateHelmet())
            scene.player.pickUp(PlateArms())
            scene.player.pickUp(PlateChest())
            scene.player.pickUp(PlateLegs())
            scene.player.pickUp(TestSword())
            scene.player.pickUp(AutoRifle())
            scene.player.pickUp(Longbow())
            scene.player.pickUp(TestAxe())
            scene.player.pickUp(SmallPotion(texture: SKTexture(imageNamed:"HealthPotion"), color: .clearColor(), size: CGSizeMake(100, 100)))
            
            scene.scaleMode = .AspectFill
            view?.presentScene(scene)
        }
    }
}
