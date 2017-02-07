//
//  Villager.swift
//  testAnimation
//
//  Created by Thomas Haughton on 29/01/2017.
//  Copyright © 2017 Thomas Haughton. All rights reserved.
//

import Foundation
import SpriteKit

class VillageMayor:QuestGiver{
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.texture = SKTexture(imageNamed: "mayor")
        dialogue = ["Ah, is that a stranger I see?","Oh and you do look very strange indeed!","You're looking for a crashed pod?","Yes, I have had reports of people seeing something.","Get rid of those bandits and I'll help you out.","Oh and heres a weapon. You'll need it!"]
        completeDialogue = ["Thank you so much!", "The pod you're looking for went north","You'll have to go through the cave to get to it"]
        quest = BanditQuest()
        help = TestSword()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
